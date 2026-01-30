# Zen Arch Station


This installer combines modern features like Btrfs snapshots, Unified Kernel Images, and Secure Boot support with a streamlined package selection. No bloat, no duplicate applications - just a clean, efficient system ready for desktop use and virtualization. Perfect for users who want cutting-edge technology without the complexity.

See the [Installed Packages](#installed-packages) section below for a complete list of what gets installed.

## Features

### Core Technologies
- **linux-zen** kernel (optimized for desktop performance)
- **Btrfs** filesystem with automatic snapshots via Snapper
- **Unified Kernel Image (UKI)** with systemd-boot (no separate initramfs)
- **Secure Boot** ready with automated key enrollment (sbctl)
- **GNOME** desktop environment with Wayland
- **QEMU/KVM** virtualization with libvirt and virt-manager

### System Configuration
- **ZRAM** for compressed swap in RAM
- **Automatic snapshots** before/after package updates (snap-pac)
- **nftables** firewall with VM network support
- **NetworkManager** with iWd backend for modern Wi-Fi management
- **Pipewire** for unified audio/video handling

## Quick Start

### Prerequisites
1. Download [Arch Linux ISO](https://archlinux.org/download/)
2. Download [Ventoy](https://www.ventoy.net/) and install to USB stick
3. Download/clone this repository (`zen-arch-station` folder)
4. Copy Arch ISO and `zen-arch-station` folder to Ventoy USB stick

### UEFI/BIOS Settings
**Before booting from USB**, configure your UEFI:
- **Secure Boot**: Disabled (temporarily)
- **Virtualization** (VT-x/AMD-V): Enabled
- **Boot Mode**: UEFI (not Legacy/CSM)

### Installation Process

#### Phase 1: Base System Installation
1. Boot from Ventoy USB stick
2. Select Arch Linux ISO from Ventoy menu
3. Continue until you reach the live system shell

4. Mount the Ventoy USB:
   ```bash
   # Change Keyboard Layout (example: de)
   loadkeys de

   # Find Ventoy partition (usually /dev/sda1 or mapper device)
   lsblk
   
   # Mount it (adjust device name if needed)
   mkdir /usb
   mount /dev/sda1 /usb
   
   # If using Ventoy persistence, use:
   # mount /dev/mapper/sdX1 /usb
   ```

5. Run the installer:
   ```bash
   cd /usb/zen-arch-station
   ./install.sh
   ```

6. Answer all configuration questions:
   - Keyboard layout, network, target disk
   - Hostname, username, password
   - Timezone, language, packages

7. Wait for installation to complete

8. Follow the on-screen instructions:
   - Reboot system
   - **Immediately** enter UEFI/BIOS
   - Navigate to Secure Boot settings
   - **Delete all Secure Boot keys** (enter "Setup Mode")
   - Save & Exit

#### Phase 2: Desktop & Applications
1. Boot into your new Arch Linux system

2. Login as your user and run:
   ```bash
   ./finish.sh
   ```
   *Note: Run this as your normal user (not root). The script is located in your home directory.*
   *Note: You may be asked for your user password multiple times during this process. Please enter it when prompted.*

3. Choose whether to enroll Secure Boot keys (recommended: yes)

4. Wait for GNOME and applications to install

5. Reboot when prompted

6. **Enter UEFI/BIOS again** and **enable Secure Boot**

#### Phase 3: Verification & Manual Steps
1. Login to your system.

2. Open Ghostty (terminal) and run the verification script (automatically generated during installation):
   ```bash
   ./verify_install.sh
   ```

3. Check that all tests pass (green `[PASS]` messages).

4. Open the `manual_steps.txt` file (automatically created) and follow the optional manual configuration steps:
   - User settings (profile picture, auto-login)
   - Appearance & background customization
   - Monitor settings (refresh rate, multi-monitor setup)
   - Keyboard shortcuts, GNOME extensions, etc.

   ```bash
   nvim manual_steps.txt
   ```

5. Once finished, you can remove the verification script and the manual steps file:
   ```bash
   rm verify_install.sh manual_steps.txt
   ```

### Recovery: Rollback to Snapshot

If something goes wrong after installation:

1. Boot from Ventoy USB with Arch Linux ISO (Secure Boot disabled)
2. Mount the Ventoy USB:
   ```bash
   # Change Keyboard Layout (example: de)
   loadkeys de

   # Find Ventoy partition (usually /dev/sda1 or mapper device)
   lsblk
   
   # Mount it (adjust device name if needed)
   mkdir /usb
   mount /dev/sda1 /usb
   
   # If using Ventoy persistence, use:
   # mount /dev/mapper/sdX1 /usb
   ```

3. Run the rollback script:
   ```bash
   cd /usb/zen-arch-station
   ./rollback.sh
   ```

4. Select a working snapshot to restore
5. The script will move your current broken system to a subvolume named `@_broken_TIMESTAMP`.
6. Reboot
7. After successful rollback, **update package mirrors** (they may be outdated from the snapshot):
   ```bash
   sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
   sudo pacman -Syy
   ```
8. If the system works, run the auto-generated cleanup script to delete the old broken system:
   ```bash
   su -
   ./delete_old_system.sh
   # After cleanup, return to your normal user:
   exit
   ```
   *This script will automatically find and delete all broken subvolumes (including nested ones) and then delete itself.*

### Manual Snapshot Management

In addition to automatic snapshots, you can create and manage snapshots manually:

```bash
# List all snapshots
sudo snapper -c root list

# Create a manual snapshot
sudo snapper -c root create --description "Before testing new software"

# Delete a snapshot
sudo snapper -c root delete SNAPSHOT_ID

# Delete multiple snapshots (e.g., 10-15)
sudo snapper -c root delete 10-15
```

**Automatic snapshots** are created by:
- `snap-pac`: Before/after every pacman operation
- `snapper-timeline.timer`: Hourly timeline snapshots


## File Structure

```
zen-arch-station/
├── LICENSE             # MIT License
├── README.md           # This file
└── scripts/            # Automation scripts
    ├── install.sh      # Phase 1: Base system
    ├── finish.sh       # Phase 2: Desktop setup
    └── rollback.sh     # Recovery tool
```

## Requirements

- UEFI system (not Legacy BIOS)
- Minimum 40 GB disk space
- Internet connection (Ethernet or Wi-Fi)
- USB stick with Ventoy installed
- Target disk will be **completely wiped**

## Limitations

- **UEFI Only**: Legacy BIOS (CSM) is not supported.
- **No Dual-Boot**: The installer wipes the entire disk. Dual-booting with Windows is not supported.
- **No Hibernation**: Suspend-to-Disk is not supported because ZRAM is used instead of a physical swap partition. Suspend-to-RAM works normally.
- **Internet Required**: An active internet connection is mandatory during installation.

## Customization

All user inputs are collected at the start of `install.sh`:
- Keyboard layout (default: `de`)
- Network type (default: Ethernet)
- Target disk
- Hostname, username, password
- Timezone (default: `Europe/Berlin`)
- System language (default: `en_US.UTF-8`)
- Mirror country (default: `Germany`)
- NVIDIA drivers (yes/no)

## Installed Packages

### Base System
- **Kernel**: linux-zen, linux-zen-headers, linux-firmware
- **Microcode**: intel-ucode or amd-ucode (auto-detected)
- **Filesystem**: btrfs-progs
- **Boot**: systemd-boot (via bootctl), sbctl (Secure Boot)
- **Network**: NetworkManager, iwd (Wi-Fi backend), bluez, bluez-utils

### System Tools
- **Snapshot Management**: snapper, snap-pac
- **Firewall**: nftables
- **Compression**: zram-generator, unzip, 7zip
- **Documentation**: man-db, man-pages
- **Utilities**: git, wget, neovim, reflector, pacman-contrib, dmidecode

### Shell & Terminal
- **Shell**: zsh with plugins (zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search)
- **Terminal**: ghostty (GPU-accelerated, Wayland-native)

### Desktop Environment
- **GNOME Core**: gnome-shell, gnome-control-center, gnome-session, gnome-tweaks
- **File Manager**: nautilus with gvfs, gvfs-smb, smbclient
- **Display Manager**: gdm
- **Utilities**: gnome-keyring, gnome-system-monitor, xdg-user-dirs, xdg-desktop-portal-gnome

**Pre-configured GNOME Settings** (applied automatically during Phase 2):
- Dark mode enabled
- Accent color: Slate (neutral gray)
- Desktop wallpaper: Solid black background
- Lock screen: Solid black background
- Window buttons: Minimize, maximize, close
- Single static workspace
- Screen never turns off automatically
- No automatic suspend (AC and battery)
- Show hidden files in file chooser
- Sort directories first
- Show "Delete Permanently" option in Nautilus
- Show "Create Link" option in Nautilus

**Pre-configured Terminal Settings** (applied automatically during installation):
- Ghostty terminal: Black background with white text
- ZSH prompt: Dark blue username/host, light blue path, lambda symbol

### Applications
- **Archive Manager**: file-roller
- **Image Viewer**: loupe
- **Video Player**: celluloid
- **Music Player**: amberol
- **Document Viewer**: evince
- **Browser**: Firefox
- **IDE**: VSCode
- **Extensions**: extension-manager (for GNOME extensions)

### Audio/Video
- **Audio Server**: pipewire, pipewire-pulse, wireplumber

### Fonts & Themes
- **Fonts**: ttf-jetbrains-mono-nerd, noto-fonts-emoji
- **Themes**: gnome-themes-extra, adwaita-icon-theme

### Virtualization
- **QEMU/KVM**: qemu-desktop, libvirt, virt-manager
- **Firmware**: edk2-ovmf
- **Network**: dnsmasq (for VM networking)

### Optional (NVIDIA)
If NVIDIA drivers are selected during installation:
- nvidia-dkms, nvidia-utils, nvidia-settings, egl-wayland

## Notes

- Root and first user accounts share the same password
- Wi-Fi credentials are automatically transferred to the new system
- Snapper creates hourly snapshots (keeps 5) and daily snapshots (keeps 7)
- VMs automatically get internet access via libvirt default network (NAT)
- SSH is not installed on the host (this is a desktop system)
- iWd is used as the Wi-Fi backend for better performance and modern features

## Maintenance

To keep your system up to date and secure, you should regularly:
1. Run `yay` to update all packages (system and AUR).
2. Check [archlinux.org](https://archlinux.org/) for important news and manual intervention requirements.
3. Check this repository for updates. It will be updated when new bleeding edge technologies emerge or when there are changes to the existing ones.

## Roadmap

Features that may be added in the future:

- **LUKS Disk Encryption** - Full disk encryption for protection against physical access
- **TPM Auto-Unlock** - Automatic decryption via TPM2 without password entry
