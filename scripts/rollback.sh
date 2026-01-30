#!/bin/bash
# ==============================================================================
#  ARCH LINUX RESCUE & ROLLBACK TOOL
#  Start this from the Live ISO to restore a Btrfs Snapshot.
# ==============================================================================

set -e
set -o pipefail

# --- COLORS ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ==============================================================================
# 1. GATHER ALL USER INPUTS (BATCH MODE)
# ==============================================================================
clear
echo "==========================================="
echo "   ARCH LINUX SNAPPER ROLLBACK WIZARD"
echo "==========================================="
echo "Please answer all questions now. The rest will run automatically."
echo ""

# 1.1 Target Disk
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
    INFO=$(lsblk -d -n -o NAME,SIZE,MODEL "$disk" 2>/dev/null | awk '{$1=""; print $0}')
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

# Prefix Logic
if [[ "$MY_DISK" =~ "nvme" ]] || [[ "$MY_DISK" =~ "mmcblk" ]]; then P="p"; else P=""; fi
PART_EFI="${MY_DISK}${P}1"
PART_ROOT="${MY_DISK}${P}2"

# 1.2 Snapshot Selection
log "Mounting Btrfs Root (SubvolID=5)..."
mkdir -p /mnt
mount -o subvolid=5 "$PART_ROOT" /mnt

# Check if structure is valid
if [ ! -d "/mnt/@snapshots" ]; then
    error "No @snapshots subvolume found on $PART_ROOT! Is this a valid layout?"
fi

echo ""
echo -e "${CYAN}--- AVAILABLE SNAPSHOTS ---${NC}"

# Collect all snapshot IDs into an array
SNAPSHOT_IDS=()
while IFS= read -r snapshot_dir; do
    id=$(basename "$snapshot_dir")

    # Validate numeric ID
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        continue
    fi

    # Check if snapshot directory structure is valid
    if [ -d "${snapshot_dir}/snapshot" ]; then
        SNAPSHOT_IDS+=("$id")
    fi
done < <(find /mnt/@snapshots -maxdepth 1 -type d -name '[0-9]*' 2>/dev/null)

# Sort numerically (ascending)
IFS=$'\n' SORTED_IDS=($(sort -n <<<"${SNAPSHOT_IDS[*]}"))
unset IFS

# Display sorted snapshots
for id in "${SORTED_IDS[@]}"; do
    snapshot_dir="/mnt/@snapshots/$id"
    DESC="No description"
    DATE=""

    if [ -f "${snapshot_dir}/info.xml" ]; then
        DESC=$(grep "<description>" "${snapshot_dir}/info.xml" 2>/dev/null | sed -e 's,.*<description>\([^<]*\)</description>.*,\1,g' || echo "No description")
        DATE=$(grep "<date>" "${snapshot_dir}/info.xml" 2>/dev/null | sed -e 's,.*<date>\([^<]*\)</date>.*,\1,g' || echo "")
    fi

    printf "ID: ${YELLOW}%-4s${NC} | %s | %s\n" "$id" "$DATE" "$DESC"
done

echo "---------------------------"
echo ""

read -p "Enter Snapshot ID to restore (e.g., 45): " SNAP_ID
if [ ! -d "/mnt/@snapshots/$SNAP_ID/snapshot" ]; then
    error "Snapshot ID $SNAP_ID not found!"
fi



# 1.4 Final Confirmation
echo ""
echo "=========================================="
echo "SUMMARY:"
echo "Disk:       $MY_DISK"
echo "Restore ID: $SNAP_ID"

echo "=========================================="
warn "WARNING: This will replace your current system (@) with Snapshot $SNAP_ID!"
read -p "Type 'yes' to start rollback (NO TURNING BACK): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted by user."
    umount /mnt
    exit 0
fi

# ==============================================================================
# 2. EXECUTION PHASE (AUTOMATED)
# ==============================================================================
log "Starting rollback..."

# 2.1 Move current system
log "Moving current broken system to /@_broken_$(date +%s)..."
BROKEN_SUBVOL="@_broken_$(date +%s)"
mv /mnt/@ "/mnt/$BROKEN_SUBVOL"

# 2.2 Restore Snapshot
log "Restoring Snapshot $SNAP_ID to /@..."
btrfs subvolume snapshot "/mnt/@snapshots/$SNAP_ID/snapshot" /mnt/@

# 2.3 Ensure Read-Write
log "Ensuring Read-Write permissions..."
btrfs property set -ts /mnt/@ ro false || log "Could not set RW property (maybe already RW)."

# 2.4 Reinstall Kernel (UKI Fix)
log "Preparing Chroot to fix Bootloader/UKI..."
umount /mnt || error "Failed to unmount /mnt"

# Mount actual system structure with error checking
mount -o subvol=@,compress=zstd:1,noatime "$PART_ROOT" /mnt || error "Failed to mount root (@)"
mount "$PART_EFI" /mnt/boot || error "Failed to mount EFI partition"
mount -o subvol=@home,compress=zstd:1,noatime "$PART_ROOT" /mnt/home || error "Failed to mount @home"
mount -o subvol=@snapshots,compress=zstd:1,noatime "$PART_ROOT" /mnt/.snapshots || error "Failed to mount @snapshots"
mount -o subvol=@log,compress=zstd:1,noatime "$PART_ROOT" /mnt/var/log || error "Failed to mount @log"
mount -o subvol=@images,nodatacow,noatime "$PART_ROOT" /mnt/var/lib/libvirt/images || error "Failed to mount @images"

# Create cache directory if missing (may not exist in old snapshots)
mkdir -p /mnt/var/cache/pacman/pkg
mount -o subvol=@cache,nodatacow,noatime "$PART_ROOT" /mnt/var/cache/pacman/pkg || warn "Failed to mount @cache (continuing anyway)"

log "All filesystems mounted successfully."

log "Entering Chroot to reinstall kernel..."
cat <<'EOF' > /mnt/rollback_chroot.sh
#!/bin/bash
set -e

# Define logging functions (not available from parent in chroot context)
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

echo "--> Reinstalling Kernel to trigger UKI rebuild..."

# Remove stale pacman lockfile from snapshot
if [ -f /var/lib/pacman/db.lck ]; then
    echo "Removing stale pacman lock file..."
    rm /var/lib/pacman/db.lck
fi

# We must copy the kernel from the snapshot (/usr/lib/modules/...) to /boot
# before regenerating the UKI, otherwise we get a kernel mismatch.
echo "Syncing kernel from snapshot to /boot..."

# Simply find the kernel file in /usr/lib/modules - no complex version parsing needed
KERNEL_FILE=$(find /usr/lib/modules -name vmlinuz -type f 2>/dev/null | head -n 1)

if [ -n "$KERNEL_FILE" ] && [ -f "$KERNEL_FILE" ]; then
    log "Found kernel at $KERNEL_FILE"
    cp -f "$KERNEL_FILE" /boot/vmlinuz-linux-zen
    log "Kernel restored to /boot/vmlinuz-linux-zen"
else
    error "CRITICAL: Could not find kernel file in snapshot! Rollback cannot continue safely."
fi

# Rebuild UKI directly instead of reinstalling kernel packages
echo "Regenerating Unified Kernel Images (UKI)..."
mkinitcpio -P

# Re-sign for Secure Boot (if sbctl is installed and keys exist)
if command -v sbctl &> /dev/null && [ -d /usr/share/secureboot/keys ]; then
    echo "Re-signing EFI binaries for Secure Boot..."
    sbctl sign-all
fi

# Verify UKI was created successfully
if [ ! -f /boot/EFI/Linux/arch-linux-zen.efi ]; then
    echo "CRITICAL: UKI rebuild failed! System may not boot."
    echo ""
    echo "The snapshot was restored but the bootloader is broken."
    echo "You need to fix this manually in chroot:"
    echo "1. arch-chroot /mnt"
    echo "2. mkinitcpio -P"
    echo "3. Exit and reboot"
    exit 1
fi

echo "UKI successfully rebuilt and verified."
EOF

chmod +x /mnt/rollback_chroot.sh
arch-chroot /mnt /rollback_chroot.sh
rm /mnt/rollback_chroot.sh

# 2.5 Create Cleanup Script for User
log "Creating cleanup script for the user..."
cat <<EOF > /mnt/root/delete_old_system.sh
#!/bin/bash
# Auto-generated cleanup script from rollback
set -e

if [ "\$EUID" -ne 0 ]; then
    echo "Please run as root!"
    exit 1
fi

echo "=========================================="
echo "   CLEANING UP OLD BROKEN SYSTEMS"
echo "=========================================="

# Mount the root partition to /mnt to see subvolumes
# Device: $PART_ROOT
if mountpoint -q /mnt; then
    echo "/mnt is already mounted. Unmounting..."
    umount /mnt
fi

echo "Mounting $PART_ROOT (subvolid=5) to /mnt..."
mount -o subvolid=5 "$PART_ROOT" /mnt

# Find broken subvolumes
BROKEN_VOLS=\$(ls -d /mnt/@_broken_* 2>/dev/null || true)

if [ -z "\$BROKEN_VOLS" ]; then
    echo "No broken subvolumes found."
else
    echo "Found:"
    echo "\$BROKEN_VOLS"
    echo ""
    echo "Deleting..."
    
    for vol in \$BROKEN_VOLS; do
        echo "Processing \$vol..."
        # Recursive delete for nested subvolumes
        btrfs subvolume list -o "\$vol" 2>/dev/null | awk '{print \$NF}' | while read sub; do
            echo "  Deleting nested: \$sub"
            btrfs subvolume delete "/mnt/\$sub" || true
        done
        
        echo "  Deleting main: \$vol"
        btrfs subvolume delete "\$vol"
    done
    echo ""
    echo "All broken systems deleted successfully."
fi

echo "Unmounting..."
umount /mnt

echo ""
echo "Self-destructing this script..."
rm -- "\$0"
echo "Done."
EOF

chmod +x /mnt/root/delete_old_system.sh



umount -R /mnt
echo ""
echo "==========================================="
echo "   ROLLBACK COMPLETE! REBOOT NOW."
echo "==========================================="
echo ""
echo -e "${YELLOW}NOTE: Your old system was saved as a subvolume:${NC}"
echo -e "${CYAN}$BROKEN_SUBVOL${NC}"
echo ""
echo "If the rollback was successful, you can delete the old system later."
echo "A cleanup script has been created for you at:"
echo -e "${GREEN}/root/delete_old_system.sh${NC}"
echo ""
echo "Run it after rebooting into your restored system (as root):"
echo -e "${GREEN}su -${NC}"
echo -e "${GREEN}./delete_old_system.sh${NC}"
echo ""
echo -e "${YELLOW}IMPORTANT: Package mirrors from the snapshot may be outdated.${NC}"
echo "After first boot, update them with:"
echo -e "${GREEN}sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist${NC}"
echo -e "${GREEN}sudo pacman -Syy${NC}"
echo ""
