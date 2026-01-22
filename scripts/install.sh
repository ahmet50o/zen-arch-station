#!/bin/bash
# ==============================================================================
#  ARCH LINUX INSTALLER
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

# --- HELPER FUNCTIONS ---
ask_option() {
    local prompt="$1"
    local default_val="$2"
    shift 2
    local options=("$@")
    
    # Print options to stderr
    for i in "${!options[@]}"; do
        echo "$((i+1))) ${options[$i]}" >&2
    done
    
    # Find index of default value
    local default_idx=""
    for i in "${!options[@]}"; do
        if [ "${options[$i]}" == "$default_val" ]; then
            default_idx=$((i+1))
            break
        fi
    done
    
    local input
    while true; do
        if [ -n "$default_idx" ]; then
            read -p "$prompt [$default_idx]: " input
        else
            read -p "$prompt: " input
        fi
        
        if [ -z "$input" ] && [ -n "$default_val" ]; then
            echo "$default_val"
            return
        fi
        
        if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -ge 1 ] && [ "$input" -le "${#options[@]}" ]; then
            echo "${options[$((input-1))]}"
            return
        fi
        
        echo "Invalid option. Please try again." >&2
    done
}

# --- ERROR HANDLING & CLEANUP ---
cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo ""
        echo -e "${RED}!!! INSTALLATION FAILED (Exit Code: $exit_code) !!!${NC}"
        echo -e "${RED}Initiating safe cleanup (unmounting only)...${NC}"

        # Unmount everything
        umount -R /mnt 2>/dev/null || true

        # SAFETY: Do NOT automatically wipe disk on error
        # User can manually clean disk if needed
        if [ -b "$MY_DISK" ]; then
            echo ""
            echo -e "${YELLOW}WARNING: Disk $MY_DISK has partial installation data.${NC}"
            echo -e "${YELLOW}To manually wipe for clean reinstall, run:${NC}"
            echo -e "${YELLOW}  wipefs -af $MY_DISK && sgdisk -Z $MY_DISK${NC}"
        fi

        echo ""
        echo -e "${RED}Installation failed. Please check errors above and try again.${NC}"
    fi
}
trap cleanup EXIT

# ==============================================================================
# 1. GATHER ALL USER INPUTS (BATCH MODE)
# ==============================================================================
clear
echo "=== ARCH LINUX INSTALLER - CONFIGURATION ==="
echo "Please answer all questions now. The rest of the installation will run automatically."
echo ""

# 1.1 Keyboard Layout
echo ""
echo "Select Keyboard Layout:"
KEYMAPS=("de" "us" "fr" "es" "it" "uk" "ch" "at" "be" "br" "ca" "cz" "dk" "fi" "hu" "ie" "jp" "kr" "latam" "nl" "no" "pl" "pt" "ro" "ru" "se" "sg" "tr" "ua")
USER_KEYMAP=$(ask_option "Choose layout" "de" "${KEYMAPS[@]}")
loadkeys "$USER_KEYMAP"

# 1.2 Network
echo ""
echo "Network Connection:"
echo "1) Ethernet (Cable)"
echo "2) Wi-Fi"
read -p "Select connection type [1]: " NET_TYPE
NET_TYPE=${NET_TYPE:-1}

USE_WIFI=false
WIFI_SSID=""
WIFI_PASS=""

if [ "$NET_TYPE" == "2" ]; then
    USE_WIFI=true
    echo "Scanning for Wi-Fi networks..."
    # Dynamic detection
    WIFI_DEV=$(iwctl device list | grep station | awk '{print $2}' | head -n 1)
    # Remove any color codes if present (just in case)
    WIFI_DEV=$(echo "$WIFI_DEV" | sed 's/\x1b\[[0-9;]*m//g')

    if [ -z "$WIFI_DEV" ]; then
        read -p "Could not detect Wi-Fi device. Enter device name manually [wlan0]: " WIFI_DEV
        WIFI_DEV=${WIFI_DEV:-wlan0}
    else
        echo "Detected Wi-Fi device: $WIFI_DEV"
    fi

    iwctl station "$WIFI_DEV" scan || true
    iwctl station "$WIFI_DEV" get-networks || true

    while true; do
        read -p "Enter Wi-Fi SSID: " WIFI_SSID
        # Validate SSID: not empty, no slashes (used in filename)
        if [[ -n "$WIFI_SSID" ]] && [[ ! "$WIFI_SSID" =~ [/\\] ]]; then
            break
        else
            echo "Invalid SSID. Cannot be empty or contain / or \\ characters."
        fi
    done

    while true; do
        read -s -p "Enter Wi-Fi Password: " WIFI_PASS
        echo ""

        # Validate password (WPA2 requires 8-63 characters)
        if [ -z "$WIFI_PASS" ]; then
            echo "Password cannot be empty."
            continue
        elif [ ${#WIFI_PASS} -lt 8 ]; then
            echo "Password must be at least 8 characters (WPA2 requirement)."
            continue
        elif [ ${#WIFI_PASS} -gt 63 ]; then
            echo "Password must be at most 63 characters."
            continue
        else
            break
        fi
    done
fi

# 1.3 Disk Selection
echo ""
echo "Available Disks:"
# Store disks in array
mapfile -t DISKS < <(lsblk -d -n -o NAME,SIZE,MODEL,TYPE | grep -E 'disk|nvme|mmcblk' | awk '{print "/dev/"$1}')

if [ ${#DISKS[@]} -eq 0 ]; then
    error "No disks found!"
fi

# Display disks with numbers
i=1
for disk in "${DISKS[@]}"; do
    # Get size and model
    INFO=$(lsblk -d -n -o SIZE,MODEL "$disk" 2>/dev/null || echo "Unknown")
    echo "$i) $disk ($INFO)"
    ((i++))
done

echo ""
while true; do
    read -p "Select disk by number or enter path (e.g., /dev/nvme0n1): " DISK_INPUT
    
    # Check if input is a number
    if [[ "$DISK_INPUT" =~ ^[0-9]+$ ]]; then
        # Number selection
        if [ "$DISK_INPUT" -ge 1 ] && [ "$DISK_INPUT" -le "${#DISKS[@]}" ]; then
            MY_DISK="${DISKS[$((DISK_INPUT-1))]}"
            break
        else
            echo "Invalid selection. Please choose 1-${#DISKS[@]}"
        fi
    elif [ -b "$DISK_INPUT" ]; then
        # Direct path input
        MY_DISK="$DISK_INPUT"
        break
    else
        echo "Invalid input. Disk '$DISK_INPUT' not found."
    fi
done

echo "Selected: $MY_DISK"
warn "WARNING: $MY_DISK will be completely wiped!"
read -p "Type 'yes' to confirm: " DISK_CONFIRM
if [ "$DISK_CONFIRM" != "yes" ]; then
    error "Disk selection aborted by user."
fi

# 1.4 User & Hostname
echo ""
while true; do
    read -p "Hostname: " MY_HOSTNAME
    if [[ "$MY_HOSTNAME" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$ ]] && [ ${#MY_HOSTNAME} -ge 2 ]; then
        break
    else
        echo "Invalid hostname. Use letters, numbers, hyphens (not at start/end), min 2 chars."
    fi
done

while true; do
    read -p "Username: " MY_USER
    if [[ "$MY_USER" =~ ^[a-z_][a-z0-9_-]*$ ]] && [ ${#MY_USER} -ge 2 ]; then
        break
    else
        echo "Invalid username. Must start with lowercase letter or underscore, only lowercase letters, numbers, underscore, hyphen allowed (min 2 chars)."
    fi
done

while true; do
    echo "Password (User & Root):"
    read -s MY_PASSWORD
    echo ""
    
    if [ -z "$MY_PASSWORD" ]; then
        echo "Password cannot be empty. Please try again."
        continue
    fi
    
    echo "Confirm Password:"
    read -s MY_PASSWORD_CONFIRM
    echo ""
    
    if [ "$MY_PASSWORD" = "$MY_PASSWORD_CONFIRM" ]; then
        unset MY_PASSWORD_CONFIRM
        break
    else
        echo "Passwords do not match. Please try again."
        unset MY_PASSWORD MY_PASSWORD_CONFIRM
    fi
done

# 1.5 Timezone
echo ""
echo "Select Timezone:"
TIMEZONES=("Europe/Berlin" "Europe/London" "Europe/Paris" "Europe/Amsterdam" "Europe/Vienna" "Europe/Zurich" "America/New_York" "America/Los_Angeles" "America/Chicago" "America/Toronto" "Asia/Tokyo" "Asia/Shanghai" "Asia/Singapore" "Australia/Sydney")
USER_TIMEZONE=$(ask_option "Choose timezone" "Europe/Berlin" "${TIMEZONES[@]}")

# 1.5b Language
echo ""
echo "Select System Language:"
LANGUAGES=("en_US.UTF-8" "de_DE.UTF-8" "fr_FR.UTF-8" "es_ES.UTF-8" "it_IT.UTF-8" "ja_JP.UTF-8" "zh_CN.UTF-8")
USER_LANG=$(ask_option "Choose language" "en_US.UTF-8" "${LANGUAGES[@]}")

# 1.6 NVIDIA
echo ""
USE_NVIDIA=false
read -p "Install NVIDIA Drivers & Hooks? (y/n): " yn
[[ "$yn" =~ ^[YyJj] ]] && USE_NVIDIA=true

# 1.7 Mirrors
echo ""
echo "Select Mirror Country:"
COUNTRIES=("Germany" "France" "United Kingdom" "United States" "Canada" "Japan" "China" "Australia" "Netherlands" "Switzerland" "Austria")
target_country=$(ask_option "Choose country" "Germany" "${COUNTRIES[@]}")


# 1.8 Final Confirmation
echo ""
echo "=========================================="
echo "SUMMARY:"
echo "Disk:       $MY_DISK (WILL BE WIPED!)"
echo "User:       $MY_USER"
echo "Hostname:   $MY_HOSTNAME"
echo "Timezone:   $USER_TIMEZONE"
echo "NVIDIA:     $USE_NVIDIA"
echo "Mirrors:    $target_country"
echo "Language:   $USER_LANG"
echo "=========================================="
read -p "Type 'yes' to start installation (NO TURNING BACK): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted by user."
    trap - EXIT # Disable cleanup trap for clean exit
    exit 0
fi

# ==============================================================================
# 2. EXECUTION PHASE (AUTOMATED)
# ==============================================================================
log "Starting installation..."

# 2.1 Network Connection
if [ "$USE_WIFI" = true ]; then
    log "Connecting to Wi-Fi..."
    iwctl --passphrase "$WIFI_PASS" station "$WIFI_DEV" connect "$WIFI_SSID"
    log "Waiting for connection to establish..."
    sleep 10
fi

log "Checking connectivity..."
if ! ping -c 3 archlinux.org > /dev/null 2>&1; then
    error "No internet connection! Please check your cable or Wi-Fi settings."
fi

# 2.2 Time & Mirrors
log "Updating time and mirrors..."
timedatectl set-ntp true

if pacman -Sy --noconfirm reflector; then
    if ! reflector --country "$target_country" --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist; then
        warn "Fallback to DE/NL..."
        reflector --country Germany,Netherlands --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    fi
else
    warn "Failed to install reflector. Skipping mirror ranking. Using default mirrorlist."
fi

# 2.3 Partitioning
log "Partitioning $MY_DISK..."
if [[ "$MY_DISK" =~ "nvme" ]] || [[ "$MY_DISK" =~ "mmcblk" ]]; then P="p"; else P=""; fi
PART_EFI="${MY_DISK}${P}1"
PART_ROOT="${MY_DISK}${P}2"

# Safety check size
DISK_SIZE_BYTES=$(lsblk -b -n -d -o SIZE "$MY_DISK")
DISK_SIZE_GB=$((DISK_SIZE_BYTES / 1024 / 1024 / 1024))
MIN_SIZE_BYTES=$((40 * 1024 * 1024 * 1024)) # 40 GiB
RECOMMENDED_SIZE_BYTES=$((80 * 1024 * 1024 * 1024)) # 80 GiB

log "Disk size: ${DISK_SIZE_GB} GiB"

if [ "$DISK_SIZE_BYTES" -lt "$MIN_SIZE_BYTES" ]; then
    error "The disk $MY_DISK is smaller than 40 GiB. Installation aborted."
elif [ "$DISK_SIZE_BYTES" -lt "$RECOMMENDED_SIZE_BYTES" ]; then
    warn "Disk is smaller than recommended 80 GiB. Installation may run out of space."
    read -p "Continue anyway? (yes/no): " CONTINUE_SMALL
    if [ "$CONTINUE_SMALL" != "yes" ]; then
        error "Installation aborted by user."
    fi
fi

wipefs -af "$MY_DISK"
sgdisk -Z "$MY_DISK"
parted -s "$MY_DISK" mklabel gpt
parted -s "$MY_DISK" mkpart EFI fat32 1MiB 2049MiB
parted -s "$MY_DISK" set 1 esp on
parted -s "$MY_DISK" mkpart root btrfs 2049MiB 100%
sleep 2

mkfs.fat -F32 -n EFI "$PART_EFI"
mkfs.btrfs -fL ArchRoot "$PART_ROOT"

# 2.4 Btrfs Subvolumes & Mount
log "Creating Btrfs Subvolumes..."
mount "$PART_ROOT" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@images
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@cache
umount /mnt

mount -o subvol=@,compress=zstd:1,noatime "$PART_ROOT" /mnt || error "Failed to mount root"

# Verify root mount succeeded
if ! mountpoint -q /mnt; then
    error "Root filesystem not properly mounted at /mnt"
fi

mkdir -p /mnt/{boot,home,var/log,var/lib/libvirt/images,.snapshots,var/cache/pacman/pkg}
mount -o subvol=@home,compress=zstd:1,noatime "$PART_ROOT" /mnt/home || error "Failed to mount /home"
mount -o subvol=@log,compress=zstd:1,noatime "$PART_ROOT" /mnt/var/log || error "Failed to mount /var/log"
mount -o subvol=@images,nodatacow,noatime "$PART_ROOT" /mnt/var/lib/libvirt/images || error "Failed to mount libvirt images"
mount -o subvol=@snapshots,compress=zstd:1,noatime "$PART_ROOT" /mnt/.snapshots || error "Failed to mount snapshots"
mount -o subvol=@cache,nodatacow,noatime "$PART_ROOT" /mnt/var/cache/pacman/pkg || error "Failed to mount pacman cache"
mount -o umask=0077 "$PART_EFI" /mnt/boot || error "Failed to mount EFI partition"

# 2.5 Package Installation
log "Installing packages (this may take a while)..."
CPU_VENDOR=$(grep -m 1 'vendor_id' /proc/cpuinfo | awk '{print $3}')
if [[ "$CPU_VENDOR" == "AuthenticAMD" ]]; then UCODE_PKG="amd-ucode"; else UCODE_PKG="intel-ucode"; fi

PKGS="base base-devel linux-zen linux-zen-headers linux-firmware iwd $UCODE_PKG btrfs-progs snapper sbctl iptables-nft networkmanager nftables neovim git reflector pacman-contrib zram-generator man-db man-pages efibootmgr bluez bluez-utils unzip wget zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search qemu-desktop libvirt edk2-ovmf dnsmasq virt-manager dmidecode"

if [ "$USE_NVIDIA" = true ]; then
    PKGS="$PKGS nvidia-dkms nvidia-utils nvidia-settings egl-wayland"
fi

# Install packages - improved error handling
if ! pacstrap -K /mnt $PKGS; then
    error "Package installation failed. Possible causes:\n  - Network connectivity issues\n  - Invalid package names\n  - Insufficient disk space\n  - Mirror sync problems\nCheck errors above for details."
fi
genfstab -U /mnt >> /mnt/etc/fstab

# 2.6 Wi-Fi Config Transfer
if [ "$USE_WIFI" = true ]; then
    log "Transferring Wi-Fi configuration..."
    mkdir -p /mnt/var/lib/iwd
    WIFI_CONFIG_FILE="/mnt/var/lib/iwd/${WIFI_SSID}.psk"

    # Write config - heredoc with unquoted delimiter allows variable expansion
    cat <<WIFICONF > "$WIFI_CONFIG_FILE"
[Security]
Passphrase=$WIFI_PASS
WIFICONF

    chmod 600 "$WIFI_CONFIG_FILE"
fi

# 2.7 Chroot Script Generation
HOOK_TARGETS="Target=$UCODE_PKG"
if [ "$USE_NVIDIA" = true ]; then
    HOOK_TARGETS="Target=nvidia-dkms
$HOOK_TARGETS"
fi

# --- SECURE VARIABLE PASSING ---
# We write variables to a separate file to avoid heredoc expansion issues with special chars in passwords.

# Get root partition UUID before entering chroot
ROOT_PART_UUID=$(blkid -s UUID -o value "$PART_ROOT")

# Encode password in base64 to safely handle special characters in heredoc
MY_PASSWORD_B64=$(echo -n "$MY_PASSWORD" | base64 -w 0)

cat <<VARS > /mnt/install_vars.sh
USER_TIMEZONE='$USER_TIMEZONE'
MY_HOSTNAME='$MY_HOSTNAME'
USER_KEYMAP='$USER_KEYMAP'
MY_USER='$MY_USER'
MY_PASSWORD_B64='$MY_PASSWORD_B64'
target_country='$target_country'
USE_WIFI='$USE_WIFI'
HOOK_TARGETS='$HOOK_TARGETS'
ROOT_PART_UUID='$ROOT_PART_UUID'
USER_LANG='$USER_LANG'
VARS

# Ensure the vars file is only readable by root inside chroot
chmod 600 /mnt/install_vars.sh

cat <<'EOF' > /mnt/setup_internal.sh
#!/bin/bash
set -e
source /install_vars.sh

# Decode password from base64
MY_PASSWORD=$(echo "$MY_PASSWORD_B64" | base64 -d)

echo "--> [CHROOT] Configuring System..."

ln -sf /usr/share/zoneinfo/$USER_TIMEZONE /etc/localtime
hwclock --systohc
echo "$MY_HOSTNAME" > /etc/hostname
echo "LANG=$USER_LANG" > /etc/locale.conf
echo "KEYMAP=$USER_KEYMAP" > /etc/vconsole.conf
echo "$USER_LANG UTF-8" >> /etc/locale.gen
locale-gen

# Save Installer Config for Stage 2 (finish.sh)
mkdir -p /etc/installer
cat <<CONF > /etc/installer/config
USE_NVIDIA="$USE_NVIDIA"
USER_KEYMAP="$USER_KEYMAP"
CONF

# Hosts file
cat <<HOSTS > /etc/hosts
127.0.0.1 localhost
::1 localhost
127.0.1.1 $MY_HOSTNAME.localdomain $MY_HOSTNAME
HOSTS

useradd -m -G wheel,libvirt -s /bin/zsh $MY_USER
echo "$MY_USER:$MY_PASSWORD" | chpasswd
echo "root:$MY_PASSWORD" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel_auth
chmod 440 /etc/sudoers.d/wheel_auth

# NetworkManager
mkdir -p /etc/NetworkManager/conf.d
cat <<NMCONF > /etc/NetworkManager/conf.d/99-libvirt.conf
[keyfile]
unmanaged-devices=interface-name:virbr0
NMCONF

systemctl enable NetworkManager bluetooth libvirtd
sed -i '/^hosts:/ s/dns/libvirt libvirt_guest dns/' /etc/nsswitch.conf

if [ "$USE_WIFI" = true ]; then
    echo "[device]" > /etc/NetworkManager/conf.d/wifi_backend.conf
    echo "wifi.backend=iwd" >> /etc/NetworkManager/conf.d/wifi_backend.conf
    systemctl mask wpa_supplicant
    systemctl enable iwd
fi

# Reflector
mkdir -p /etc/xdg/reflector
cat <<REFLECTOR > /etc/xdg/reflector/reflector.conf
--save /etc/pacman.d/mirrorlist
--country $target_country
--protocol https
--sort rate
--age 12
REFLECTOR

# Bootloader & UKI
mkdir -p /boot/EFI/Linux

# Use the UUID passed from install_vars.sh
ROOT_UUID="$ROOT_PART_UUID"

CMDLINE="root=UUID=$ROOT_UUID rw rootflags=subvol=@,compress=zstd:1,noatime quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3"

# Check for Nvidia in HOOK_TARGETS to decide cmdline
if [[ "$HOOK_TARGETS" == *"nvidia"* ]]; then
    CMDLINE="$CMDLINE nvidia_drm.modeset=1 nvidia_drm.fbdev=1"
    sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
fi
echo "$CMDLINE" > /etc/kernel/cmdline

# Hook
mkdir -p /etc/pacman.d/hooks
cat <<HOOK > /etc/pacman.d/hooks/91-uki-update-custom.hook
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
$HOOK_TARGETS

[Action]
Description=Update UKIs...
When=PostTransaction
Depends=mkinitcpio
Exec=/usr/bin/mkinitcpio -P
HOOK

# Secure Boot auto-signing hook
cat <<'HOOK' > /etc/pacman.d/hooks/92-sbctl-sign.hook
[Trigger]
Operation=Install
Operation=Upgrade
Type=Path
Target=boot/EFI/Linux/*.efi
Target=boot/EFI/systemd/*.efi
Target=boot/EFI/BOOT/*.efi
Target=usr/lib/systemd/boot/efi/*.efi

[Action]
Description=Re-signing EFI binaries for Secure Boot...
When=PostTransaction
Depends=sbctl
NeedsTargets
Exec=/usr/bin/sbctl sign-all
HOOK

# Preset
cat <<PRESET > /etc/mkinitcpio.d/linux-zen.preset
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux-zen"
PRESETS=('default')
default_config="/etc/mkinitcpio.conf"
default_options="--cmdline /etc/kernel/cmdline"
default_uki="/boot/EFI/Linux/arch-linux-zen.efi"
PRESET

mkinitcpio -P

# Verify UKI creation
if [ ! -f "/boot/EFI/Linux/arch-linux-zen.efi" ]; then
    echo "ERROR: UKI not found at /boot/EFI/Linux/arch-linux-zen.efi"
    exit 1
fi
echo "UKI created successfully."
bootctl install
systemctl enable systemd-boot-update.service

cat <<LOADER > /boot/loader/loader.conf
timeout 0
console-mode auto
editor no
LOADER

# Snapper
# We need to handle the subvolume correctly for create-config
umount /.snapshots
rm -rf /.snapshots
snapper --no-dbus -c root create-config /
# Snapper creates a subvolume, we need to remove it to mount our @snapshots subvolume
btrfs subvolume delete /.snapshots
mkdir -p /.snapshots
mount -a

# Configure Snapper
snapper --no-dbus -c root set-config \
    ALLOW_GROUPS="wheel" \
    TIMELINE_CREATE="yes" \
    TIMELINE_CLEANUP="yes" \
    NUMBER_LIMIT="50" \
    NUMBER_LIMIT_IMPORTANT="10" \
    TIMELINE_LIMIT_HOURLY="5" \
    TIMELINE_LIMIT_DAILY="7" \
    TIMELINE_LIMIT_WEEKLY="0" \
    TIMELINE_LIMIT_MONTHLY="0" \
    TIMELINE_LIMIT_YEARLY="0" \
    BACKGROUND_COMPARISON="yes"

echo 'SNAPPER_CONFIGS="root"' >> /etc/conf.d/snapper

chmod 750 /.snapshots
chown :wheel /.snapshots

# Maintenance
cat <<ZRAM > /etc/systemd/zram-generator.conf
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
ZRAM

sed -i 's/#SystemMaxUse=/SystemMaxUse=200M/' /etc/systemd/journald.conf

echo "Installing snap-pac..."
pacman -S --noconfirm snap-pac

systemctl enable fstrim.timer reflector.timer paccache.timer snapper-timeline.timer snapper-cleanup.timer btrfs-scrub@-.timer

echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/30-ipforward.conf

cat <<NFTABLES > /etc/nftables.conf
#!/usr/bin/nft -f
# ipv4/ipv6 Simple & Safe firewall ruleset.
# More examples in /usr/share/nftables/ and /usr/share/doc/nftables/examples/.

destroy table inet filter
table inet filter {
	chain input {
		type filter hook input priority filter; policy drop;
		ct state invalid drop
		ct state {established, related} accept
		iifname "lo" accept
        iifname "virbr0" accept
		ip protocol icmp accept
		ip6 nexthdr icmpv6 accept
		tcp dport ssh accept
	}
	chain forward {
		type filter hook forward priority filter; policy drop;
        iifname "virbr0" accept
        oifname "virbr0" accept
	}
	chain output {
		type filter hook output priority filter; policy accept;
	}
}
NFTABLES

# Fix NFTables service to remain active
mkdir -p /etc/systemd/system/nftables.service.d
cat <<NFTOVERRIDE > /etc/systemd/system/nftables.service.d/override.conf
[Service]
RemainAfterExit=yes
NFTOVERRIDE

systemctl enable nftables

cat <<'ZSHRC' > /home/$MY_USER/.zshrc
export EDITOR=nvim
export VISUAL=nvim
export DIFFPROG="nvim -d"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS CORRECT
unsetopt BEEP 2>/dev/null || true
autoload -Uz colors && colors
setopt PROMPT_SUBST
PROMPT='%F{24}%n@%m%f:%F{33}%~%f %(?.%F{46}.%F{196})λ%f '
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches%f'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^[[Z" reverse-menu-complete
alias sudo='sudo '
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lAh --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias ip='ip -c'
alias ..='cd ..'
alias ...='cd ../..'
alias q='exit'
alias update='yay'
alias cleanup='yay -Yc'
alias unlock='sudo rm /var/lib/pacman/db.lck'

function check_maintenance() {
    pacnew=$(pacdiff -o 2>/dev/null)
    if [[ -n "$pacnew" ]]; then
        print -P "\n%F{red}⚠ ATTENTION: .pacnew files found:%f"
        print -P "$pacnew"
        print -P "%F{yellow}Solution: sudo pacdiff%f\n"
    fi
    failed=$(systemctl --failed --no-legend --plain)
    if [[ -n "$failed" ]]; then
        print -P "\n%F{red}⚠ FAILED SERVICES:%f"
        print -P "$failed"
        print -P "%F{yellow}Solution: systemctl status <service>%f\n"
    fi
    orphans=$(pacman -Qdtq 2>/dev/null | wc -l)
    if [[ "$orphans" -gt 0 ]]; then
         print -P "\n%F{yellow}Note: $orphans orphan packages found.%f"
         print -P "Clean up with: %F{green}cleanup%f\n"
    fi
}
check_maintenance
ZSHRC
chown $MY_USER:$MY_USER /home/$MY_USER/.zshrc

# Cleanup vars file
rm /install_vars.sh
EOF

chmod +x /mnt/setup_internal.sh
arch-chroot /mnt /setup_internal.sh
rm /mnt/setup_internal.sh

# 2.8 Copy Stage 2 & 3 Scripts + Docs
log "Copying additional scripts and documentation..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_ROOT=$( dirname "$SCRIPT_DIR" )


if [ -f "$SCRIPT_DIR/finish.sh" ]; then
    cp "$SCRIPT_DIR/finish.sh" "/mnt/home/$MY_USER/finish.sh"
    arch-chroot /mnt chown $MY_USER:$MY_USER /home/$MY_USER/finish.sh
    arch-chroot /mnt chmod +x /home/$MY_USER/finish.sh
fi

if [ -d "$REPO_ROOT/docs" ]; then
    cp -r "$REPO_ROOT/docs" "/mnt/home/$MY_USER/docs"
    arch-chroot /mnt chown -R $MY_USER:$MY_USER "/home/$MY_USER/docs"
fi

# Disable trap for successful exit
trap - EXIT

echo ""
echo "=== INSTALLATION STAGE 1 FINISHED SUCCESSFULLY ==="
echo "1. Type 'reboot' to restart the system."
echo "2. IMMEDIATELY go to UEFI/BIOS Settings."
echo "3. Navigate to 'Secure Boot' settings."
echo "4. Select 'Key Management' or similar."
echo "5. Choose 'Delete All Secure Boot Keys' or 'Clear Keys' to enter SETUP MODE."
echo "   (Status should change to 'Setup Mode' or 'Audit Mode')."
echo "6. Save & Exit BIOS."
echo "7. Boot into your new Arch Linux (login as $MY_USER)."
echo "8. Run './finish.sh' from your home directory to complete the setup."
echo "   (Run as your normal user, NOT as root!)"

