#!/bin/bash
# ==============================================================================
#  ARCH LINUX INSTALLER - STAGE 2
# ==============================================================================
set -e
set -o pipefail

# --- COLORS ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
pass() { echo -e "${GREEN}[PASS]${NC} $1"; }

# --- PRE-CHECK: ROOT ---
if [ "$EUID" -eq 0 ]; then
    error "Please run this script as your NORMAL USER, not as root!"
fi

# --- PRE-CHECK: LIVE ISO ---
if [ "$(hostname)" == "archiso" ]; then
    error "You are still in the Live ISO! Reboot into your new system first."
fi

# --- PRE-CHECK: LOCATION ---
# Ensure we are running from the user's home directory to avoid permission issues
if [[ "$PWD" != "/home/$USER"* ]]; then
    warn "You are running this script from $PWD."
    warn "It is recommended to run it from your home directory (/home/$USER)."
    read -p "Continue anyway? (y/n): " CONT
    if [[ ! "$CONT" =~ ^[YyJj] ]]; then
        exit 1
    fi
fi

# ==============================================================================
# 1. USER CONFIGURATION
# ==============================================================================
clear
echo "==========================================="
echo "   ARCH INSTALLER STAGE 2 - FINALIZING"
echo "==========================================="
echo "Please answer all questions now. The rest will run automatically."
echo ""

# 1.1 Secure Boot
echo ""
DO_SECUREBOOT=false
read -p "Enroll Secure Boot keys now? (y/n): " yn
[[ "$yn" =~ ^[YyJj] ]] && DO_SECUREBOOT=true

# 1.2 Reboot
echo ""
DO_REBOOT=false
read -p "Reboot automatically after success? (y/n): " yn
[[ "$yn" =~ ^[YyJj] ]] && DO_REBOOT=true

echo ""
echo "Starting configuration..."

# ==============================================================================
# 2. SYSTEM CONFIGURATION
# ==============================================================================

# Read Installer Config
if [ -f /etc/installer/config ]; then
    source /etc/installer/config
fi

# --- 2.1 SECURE BOOT (SBCTL) ---
if [ "$DO_SECUREBOOT" = true ]; then
    log "Checking Secure Boot Status..."
    
    # Ensure /boot is mounted before accessing EFI files
    if ! mountpoint -q /boot; then
        log "Mounting /boot partition..."
        sudo mount -a
    fi

    SB_STATUS=$(sudo sbctl status)

    if echo "$SB_STATUS" | grep -q "Setup Mode:.*Enabled"; then
        log "System is in Setup Mode. Proceeding..."
        log "Creating and enrolling keys..."
        sudo sbctl create-keys || log "Keys might already exist."
        sudo sbctl enroll-keys -m || warn "Enroll keys failed (maybe already enrolled?)"

        log "Signing Bootloader & Kernel (UKI)..."
        
        FILES_TO_SIGN=(
            "/boot/EFI/Linux/arch-linux-zen.efi"
            "/boot/EFI/systemd/systemd-bootx64.efi"
            "/boot/EFI/BOOT/BOOTX64.EFI"
            "/boot/EFI/BOOT/bootx64.efi"
        )

        for f in "${FILES_TO_SIGN[@]}"; do
            # Check existence with sudo to bypass permission restrictions on /boot
            if sudo test -f "$f"; then
                log "Signing: $f"
                sudo sbctl sign -s "$f"
            fi
        done

        # Sign systemd-boot in source directory so bootctl update uses signed version
        if sudo test -f "/usr/lib/systemd/boot/efi/systemd-bootx64.efi"; then
            log "Signing systemd-boot source for future updates..."
            sudo sbctl sign -s /usr/lib/systemd/boot/efi/systemd-bootx64.efi
        fi

        log "Verifying signatures..."
        if sudo sbctl verify | grep -q "not signed"; then
            warn "Some files might not be signed properly. Check 'sudo sbctl verify'."
        else
            log "Secure Boot verified! (Enable it in BIOS after next reboot)"
        fi

    elif echo "$SB_STATUS" | grep -q "Secure Boot:.*Enabled"; then
        log "Secure Boot is ALREADY ENABLED. Skipping key creation."
    else
        warn "System is NOT in Setup Mode. Skipping Secure Boot setup."
        warn "You need to clear keys in BIOS to enter Setup Mode."
    fi
else
    log "Skipping Secure Boot setup as requested."
fi

# --- 2.2 YAY (AUR HELPER) ---
log "Installing Yay (AUR Helper)..."
if ! command -v yay &> /dev/null; then
    # Ensure prerequisites are present
    sudo pacman -S --noconfirm git base-devel || error "Failed to install build dependencies"

    rm -rf yay
    if git clone https://aur.archlinux.org/yay.git; then
        cd yay
        if ! makepkg -si --noconfirm; then
            cd ..
            rm -rf yay
            error "Failed to build yay. Check build output above."
        fi
        cd ..
        rm -rf yay
    else
        error "Failed to clone yay repository. Check your internet connection."
    fi
else
    log "Yay is already installed."
fi

# --- 2.3 CPU VIRTUALIZATION CHECK ---
log "Checking CPU Virtualization Support..."
HW_VIRT_AVAILABLE=false

# Check for Intel VT-x or AMD-V
if grep -qE 'vmx|svm' /proc/cpuinfo; then
    pass "CPU supports hardware virtualization (VT-x/AMD-V)."

    # Check if KVM module is loaded
    if [ -e /dev/kvm ]; then
        pass "/dev/kvm exists. KVM is ready."
        HW_VIRT_AVAILABLE=true
    else
        warn "/dev/kvm NOT found. Attempting to load KVM modules..."

        # Detect CPU vendor and load appropriate module
        if grep -q 'vmx' /proc/cpuinfo; then
            sudo modprobe kvm_intel && log "Loaded kvm_intel module."
        elif grep -q 'svm' /proc/cpuinfo; then
            sudo modprobe kvm_amd && log "Loaded kvm_amd module."
        fi

        # Recheck
        if [ -e /dev/kvm ]; then
            pass "/dev/kvm now available."
            HW_VIRT_AVAILABLE=true
        else
            error "CRITICAL: /dev/kvm still missing! Please enable VT-x/AMD-V in BIOS and reboot."
        fi
    fi
else
    error "CRITICAL: CPU does NOT support hardware virtualization!

    This system requires Intel VT-x or AMD-V to run VMs.

    Solution:
    1. Reboot and enter BIOS/UEFI settings
    2. Look for 'Virtualization Technology', 'Intel VT-x', or 'AMD-V'
    3. Enable it and save
    4. Reboot and run this script again

    If your CPU is too old, it may not support virtualization at all."
fi

# --- 2.4 LIBVIRT NETWORK ---
log "Configuring Libvirt Network..."

if [ "$HW_VIRT_AVAILABLE" = false ]; then
    warn "Skipping libvirt setup (no virtualization support)."
else
    # Ensure libvirtd is started
    if ! systemctl is-active --quiet libvirtd; then
        log "Starting libvirtd service..."
        sudo systemctl start libvirtd || error "Failed to start libvirtd. Check 'systemctl status libvirtd'."

        # Wait for service to fully initialize
        sleep 3
    fi

    # Verify service is truly running
    if systemctl is-active --quiet libvirtd; then
        pass "Libvirt service is running."

        # Check if default network already exists
        if sudo virsh net-list --all | grep -q "default"; then
            log "Default network already exists."
        else
            log "Defining default network..."
            if [ -f /etc/libvirt/qemu/networks/default.xml ]; then
                sudo virsh net-define /etc/libvirt/qemu/networks/default.xml || warn "Failed to define network (may already exist)."
            else
                warn "/etc/libvirt/qemu/networks/default.xml not found. Creating manually..."

                # Create default network XML if missing
                sudo mkdir -p /etc/libvirt/qemu/networks
                cat <<NETXML | sudo tee /etc/libvirt/qemu/networks/default.xml > /dev/null
<network>
  <name>default</name>
  <uuid>9a05da11-e96b-47f3-8253-a3a482e445f5</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
NETXML
                sudo virsh net-define /etc/libvirt/qemu/networks/default.xml || error "Failed to define network."
            fi
        fi

        # Set network to autostart
        sudo virsh net-autostart default 2>/dev/null || log "Network already set to autostart."

        # Start the network
        if sudo virsh net-list --inactive | grep -q "default"; then
            log "Starting default network..."
            sudo virsh net-start default || warn "Failed to start network (may already be running)."
        fi

        # Verify virbr0 exists
        sleep 2
        if ip link show virbr0 >/dev/null 2>&1; then
            pass "Virtual Bridge (virbr0) created successfully."
        else
            warn "virbr0 NOT found! Debugging info:"
            sudo virsh net-list --all
            ip addr show
        fi

        log "Libvirt network 'default' configured."
    else
        error "libvirtd failed to start. Check logs with: sudo journalctl -xeu libvirtd"
    fi
fi

# --- 2.5 GNOME & APPS ---
log "Installing GNOME Desktop & Tools..."

GNOME_PKGS="gdm gnome-shell gnome-control-center gnome-session nautilus \
gnome-keyring gnome-tweaks xdg-user-dirs xdg-desktop-portal-gnome \
gnome-themes-extra adwaita-icon-theme pipewire pipewire-pulse wireplumber \
gnome-system-monitor smbclient gvfs gvfs-smb \
ttf-jetbrains-mono-nerd noto-fonts-emoji file-roller 7zip loupe celluloid amberol evince \
ghostty"

sudo pacman -S --noconfirm $GNOME_PKGS

log "Enabling GDM (Display Manager)..."
sudo systemctl enable gdm

log "Updating User Dirs..."
xdg-user-dirs-update

# --- 2.6 GNOME CONFIGURATION (USER SETTINGS) ---
log "Applying User Preferences..."

# Function to safely apply gsettings with error handling
apply_gsetting() {
    local schema="$1"
    local key="$2"
    local value="$3"
    if ! gsettings set "$schema" "$key" "$value" 2>/dev/null; then
        warn "Failed to set $schema $key (schema may not exist)"
    fi
}

# Dark Mode
apply_gsetting org.gnome.desktop.interface color-scheme 'prefer-dark'

# Accent Color: Slate (neutral gray)
apply_gsetting org.gnome.desktop.interface accent-color 'slate'

# Wallpaper: Solid Black Background
apply_gsetting org.gnome.desktop.background color-shading-type 'solid'
apply_gsetting org.gnome.desktop.background primary-color '#000000'

# Lock Screen: Solid Black Background
apply_gsetting org.gnome.desktop.screensaver color-shading-type 'solid'
apply_gsetting org.gnome.desktop.screensaver primary-color '#000000'

# Window Buttons (Min/Max/Close)
apply_gsetting org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Workspaces (Static: 1)
apply_gsetting org.gnome.mutter dynamic-workspaces false
apply_gsetting org.gnome.desktop.wm.preferences num-workspaces 1

# Power Saving (Idle Delay = 0 / Never turn off screen automatically)
apply_gsetting org.gnome.desktop.session idle-delay 0
# Disable Automatic Suspend (AC and Battery)
apply_gsetting org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
apply_gsetting org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Nautilus / File Chooser Settings
apply_gsetting org.gtk.Settings.FileChooser show-hidden true
apply_gsetting org.gtk.Settings.FileChooser sort-directories-first true
apply_gsetting org.gnome.nautilus.preferences show-delete-permanently true
apply_gsetting org.gnome.nautilus.preferences show-create-link true

# Keyboard Layout (from installer config, fallback to 'de')
GNOME_KEYMAP="${USER_KEYMAP:-de}"
# Validate keymap doesn't contain special characters that break JSON
if [[ "$GNOME_KEYMAP" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    log "Setting GNOME Keyboard Layout to '$GNOME_KEYMAP'..."
    apply_gsetting org.gnome.desktop.input-sources sources "[('xkb', '$GNOME_KEYMAP')]"
else
    warn "Invalid keymap '$GNOME_KEYMAP', skipping GNOME keyboard layout setting"
fi

# Mouse Settings (Disable Mouse Acceleration)
apply_gsetting org.gnome.desktop.peripherals.mouse accel-profile 'flat'

log "GNOME settings applied."

# --- 2.7 GHOSTTY CONFIGURATION ---
log "Creating Ghostty configuration..."
mkdir -p "/home/$USER/.config/ghostty"
cat <<'GHOSTTY_CONFIG' > "/home/$USER/.config/ghostty/config"
# Ghostty Terminal Configuration
# Black background with white text for cohesive dark theme

background = #000000
foreground = #ffffff
background-opacity = 1.0
GHOSTTY_CONFIG

chown -R $USER:$USER "/home/$USER/.config/ghostty"
log "Ghostty configuration created."

# --- 2.8 AUR PACKAGES ---
log "Installing additional AUR apps..."
yay -S --noconfirm extension-manager

# --- 2.8 SOFTWARE ---
log "Installing Firefox and VSCode..."
sudo pacman -S --noconfirm firefox code

# --- 2.9 GENERATE VERIFICATION SCRIPT ---
log "Generating verification script..."
cat <<'EOF' > "/home/$USER/verify_install.sh"
#!/bin/bash
# ==============================================================================
#  ARCH LINUX VERIFICATION SCRIPT
#  Run this AFTER 'finish.sh' and a reboot to verify your system state.
# ==============================================================================
set -o pipefail

# --- COLORS ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}[PASS]${NC} $1"; }
fail() { echo -e "${RED}[FAIL]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
info() { echo -e "${NC}[INFO] $1"; }

# ==============================================================================
# 1. PRE-CHECKS
# ==============================================================================
echo "==========================================="
echo "   SYSTEM VERIFICATION TOOL"
echo "==========================================="
echo ""

# Check for sudo upfront if not root
if [ "$EUID" -ne 0 ]; then
    echo "This script needs sudo privileges for some checks (sbctl, nft)."
    sudo -v || exit 1
fi

ERRORS=0

# ==============================================================================
# 2. VERIFICATION CHECKS
# ==============================================================================

# 2.1 FILESYSTEM (BTRFS)
info "Checking Filesystem..."
FSTYPE=$(findmnt / -n -o FSTYPE)
if [ "$FSTYPE" == "btrfs" ]; then
    pass "Root filesystem is Btrfs."
else
    fail "Root filesystem is NOT Btrfs (Found: $FSTYPE)."
    ((ERRORS++))
fi

# 2.2 SNAPPER
info "Checking Snapper..."
if systemctl is-active --quiet snapper-timeline.timer; then
    pass "Snapper Timeline Timer is active."
else
    fail "Snapper Timeline Timer is INACTIVE."
    ((ERRORS++))
fi

if sudo snapper list-configs | grep -q "root"; then
    pass "Snapper config 'root' exists."
else
    fail "Snapper config 'root' MISSING."
    info "Available configs:"
    sudo snapper list-configs || info "Could not list configs."
    ((ERRORS++))
fi

# Check permissions
if [ -r "/.snapshots" ]; then
    pass "User can read /.snapshots (Permissions OK)."
else
    fail "User CANNOT read /.snapshots (Permission Error)."
    ((ERRORS++))
fi

# 2.3 SECURE BOOT & SIGNING
info "Checking Secure Boot & Signing..."
SB_STATUS=$(sudo sbctl status 2>/dev/null)
if echo "$SB_STATUS" | grep -q "Setup Mode:.*Enabled"; then
    pass "Secure Boot is in SETUP MODE. (Ready for key enrollment/enabling in BIOS)"
    info "ACTION REQUIRED: Reboot to BIOS and Enable Secure Boot."
elif echo "$SB_STATUS" | grep -q "Secure Boot:.*Enabled"; then
    pass "Secure Boot is ENABLED and ENFORCING."
else
    warn "Secure Boot status unknown or disabled."
fi

# Check if files are signed
# With UKI, vmlinuz is embedded in the .efi file, so we ignore it
if sudo sbctl verify | grep -E "not signed" | grep -v "vmlinuz"; then
    fail "Some boot files are NOT signed!"
    sudo sbctl verify
    ((ERRORS++))
else
    pass "All critical boot files (UKI/Bootloader) are correctly signed."
fi

# 2.4 UKI (Unified Kernel Image)
info "Checking UKI..."
if sudo test -f "/boot/EFI/Linux/arch-linux-zen.efi"; then
    pass "UKI Image found at /boot/EFI/Linux/arch-linux-zen.efi"
else
    fail "UKI Image MISSING!"
    ((ERRORS++))
fi

# 2.5 ZRAM
info "Checking ZRAM..."
if zramctl | grep -q "zram0"; then
    pass "ZRAM device (zram0) is active."
else
    fail "ZRAM is NOT active."
    ((ERRORS++))
fi

# 2.5.1 KVM & VIRTUALIZATION
info "Checking CPU Virtualization & KVM..."
if grep -qE 'vmx|svm' /proc/cpuinfo; then
    pass "CPU supports hardware virtualization (VT-x/AMD-V)."
else
    fail "CPU does NOT support hardware virtualization!"
    info "ACTION REQUIRED: Enable VT-x/AMD-V in BIOS/UEFI settings."
    ((ERRORS++))
fi

if [ -e /dev/kvm ]; then
    pass "/dev/kvm device exists."

    # Check permissions
    if [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
        pass "User has read/write access to /dev/kvm."
    else
        fail "User CANNOT access /dev/kvm (Permission Error)."
        info "Current user groups: $(groups)"
        info "Try adding user to 'kvm' group: sudo usermod -aG kvm $USER"
        ((ERRORS++))
    fi
else
    fail "/dev/kvm device MISSING!"
    info "KVM module not loaded. Check: lsmod | grep kvm"
    ((ERRORS++))
fi

# 2.5.2 USER GROUP MEMBERSHIP
info "Checking User Group Membership..."
USER_GROUPS=$(groups)

if echo "$USER_GROUPS" | grep -qw "wheel"; then
    pass "User is in 'wheel' group (sudo access)."
else
    fail "User is NOT in 'wheel' group!"
    ((ERRORS++))
fi

if echo "$USER_GROUPS" | grep -qw "libvirt"; then
    pass "User is in 'libvirt' group."
else
    fail "User is NOT in 'libvirt' group!"
    info "Add with: sudo usermod -aG libvirt $USER"
    ((ERRORS++))
fi

# 2.6 NETWORK & VMs
info "Checking Network & Libvirt..."
if ping -c 1 archlinux.org >/dev/null 2>&1; then
    pass "Internet connection OK."
else
    fail "No Internet connection."
    ((ERRORS++))
fi

if systemctl is-active --quiet libvirtd; then
    pass "Libvirt service is running."

    # Check default network status
    DEFAULT_NET_STATUS=$(sudo virsh net-list --all 2>/dev/null | grep default || echo "")
    if echo "$DEFAULT_NET_STATUS" | grep -qw "active"; then
        pass "Libvirt 'default' network is active."
    else
        fail "Libvirt 'default' network is NOT active!"
        info "Debug: sudo virsh net-list --all"
        ((ERRORS++))
    fi
else
    fail "Libvirt service is NOT running."
    info "Debug commands:"
    info "  sudo systemctl status libvirtd"
    info "  sudo journalctl -xeu libvirtd"
    info "Start with: sudo systemctl start libvirtd"
    ((ERRORS++))
fi

# Check virbr0 (VM Network)
if ip link show virbr0 >/dev/null 2>&1; then
    pass "Virtual Bridge (virbr0) exists."
else
    fail "Virtual Bridge (virbr0) MISSING. VMs won't have network."
    ((ERRORS++))
fi

# Check NFTables for forwarding
NFT_RULES=$(sudo nft list ruleset 2>/dev/null) || true
if echo "$NFT_RULES" | grep -q "virbr0"; then
    pass "Firewall (nftables) allows VM traffic."
else
    fail "Firewall rules for VMs missing!"
    ((ERRORS++))
fi

# 2.7 ZSH
info "Checking ZSH..."
if [[ "$SHELL" == */zsh ]]; then
    pass "Current shell is ZSH."
else
    warn "Current shell is NOT ZSH ($SHELL). (Might need logout/login)"
fi

if [ -f "$HOME/.zshrc" ]; then
    pass ".zshrc configuration found."
else
    fail ".zshrc MISSING."
    ((ERRORS++))
fi

# 2.8 PACKAGES & SERVICES
info "Checking Critical Packages & Services..."

# Read installer config
if [ -f /etc/installer/config ]; then
    source /etc/installer/config
fi

# Check Yay
if command -v yay &> /dev/null; then
    pass "Yay AUR Helper is installed."

    # Test if yay can query AUR
    if yay -Ss '^yay$' &> /dev/null; then
        pass "Yay can query AUR repositories."
    else
        warn "Yay is installed but cannot query AUR (network issue?)."
    fi
else
    fail "Yay AUR Helper is MISSING."
    info "Reinstall with: git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    ((ERRORS++))
fi

# Check Firefox and VSCode
PACKAGES=("firefox" "code" "extension-manager" "gdm" "ghostty")
for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        pass "Package '$pkg' is installed."
    else
        fail "Package '$pkg' is MISSING."
        ((ERRORS++))
    fi
done

if systemctl is-active --quiet gdm; then
    pass "GDM Service is active."
else
    fail "GDM Service is NOT active."
    ((ERRORS++))
fi

echo ""
echo "==========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}ALL CHECKS PASSED! SYSTEM IS ROBUST.${NC}"
else
    echo -e "${RED}$ERRORS CHECKS FAILED. PLEASE REVIEW ABOVE.${NC}"
fi
echo "==========================================="
EOF
chmod +x "/home/$USER/verify_install.sh"

# --- 2.9 CLEANUP & MANUAL STEPS ---
log "Cleaning up..."
yay -Yc --noconfirm

# Create projects folder
log "Creating projects folder..."
mkdir -p "/home/$USER/projects"
mkdir -p "/home/$USER/Downloads"
mkdir -p "/home/$USER/Pictures/Screenshots"

# Add to file manager bookmarks
log "Adding projects, Downloads, and Screenshots to bookmarks..."
BOOKMARKS_DIR="/home/$USER/.config/gtk-3.0"
BOOKMARKS_FILE="$BOOKMARKS_DIR/bookmarks"
mkdir -p "$BOOKMARKS_DIR"
touch "$BOOKMARKS_FILE"

# Add bookmarks at the top
TEMP_FILE=$(mktemp) || { warn "Failed to create temp file for bookmarks"; }
if [ -n "$TEMP_FILE" ]; then
    # Write bookmarks at the top
    echo "file:///home/${USER}/projects projects" > "$TEMP_FILE"
    echo "file:///home/${USER}/Downloads Downloads" >> "$TEMP_FILE"
    echo "file:///home/${USER}/Pictures/Screenshots Screenshots" >> "$TEMP_FILE"
    # Append existing bookmarks, excluding our entries to avoid duplicates
    grep -vF -e "file:///home/${USER}/projects" -e "file:///home/${USER}/Downloads" -e "file:///home/${USER}/Pictures/Screenshots" "$BOOKMARKS_FILE" >> "$TEMP_FILE" 2>/dev/null || true
    if mv "$TEMP_FILE" "$BOOKMARKS_FILE"; then
        log "Added bookmarks to Nautilus"
    else
        warn "Failed to update bookmarks file"
        rm -f "$TEMP_FILE"
    fi
fi

MANUAL_FILE="/home/$USER/manual_steps.txt"
cat <<EOF > "$MANUAL_FILE"
============================================================
   ARCH LINUX - POST INSTALLATION MANUAL STEPS
============================================================

1. SECURE BOOT
   - Reboot to BIOS.
   - Enable Secure Boot (if not already done).
   - Verify it's active with: sbctl status

2. USER SETTINGS
   - Open Settings -> System -> Users.
   - Click on your user icon to change profile picture.
   - Enable or disable Automatic Login if desired.

3. APPEARANCE & BACKGROUND
   - Open Settings -> Appearance.
   - Choose a background image or solid color.
   - Adjust appearance settings to your preference.

4. MONITOR SETTINGS
   - Open Settings -> Displays.
   - Set Refresh Rate (Hz) to maximum.
   - Arrange monitors if using multiple.

5. GNOME KEYBOARD SHORTCUTS
   - Open Settings -> Keyboard -> View and Customize Shortcuts.
   - Custom Shortcuts -> Add:
     - Name: Terminal
     - Command: ghostty
     - Shortcut: Ctrl+Alt+T
   - System -> Power Off:
     - Set shortcut to: Ctrl+Alt+Delete

6. GNOME EXTENSIONS
   - Open 'Extension Manager' app.
   - Download and Enable desired extensions (e.g., 'No Overview at Startup').

7. NAUTILUS (FILES) CONFIGURATION
   - SMB / NAS Connection (optional):
     - Click 'Network'.
     - Connect to Server (example): smb://fritz.box (sometimes only works after reboot)
     - Enter credentials and save.

8. APP GRID
   - Open App Grid (2x Super Key).
   - Drag and drop icons to organize them.

9. VALIDATION
   - Run './verify_install.sh' to check system health.

10. CLEAR
    - If everything is done, remove verify_install.sh and
    this manual_steps.txt file if you want.

Enjoy your new Arch Linux System!

EOF

chown "${USER}":"${USER}" "$MANUAL_FILE"

echo ""
echo "============================================================"
echo "   INSTALLATION COMPLETE!"
echo "============================================================"
echo "Detailed manual steps have been saved to:"
echo "   -> $MANUAL_FILE"
echo ""

# --- REBOOT / FINISH ---
if [ "$DO_REBOOT" = true ]; then
    echo "Rebooting in 5 seconds..."
    sleep 5
    rm -- "$0"
    sudo reboot
else
    echo "Script finished. You can now manually reboot."
    echo "This script will delete itself now."
    rm -- "$0"
fi


