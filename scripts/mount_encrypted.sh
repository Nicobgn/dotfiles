#!/bin/bash
# This script is used to mount an encrypted device via cryptsetup and mount it to a specified mount point.
# Usage: mp.sh <device-uuid-or-path> <mapper_name> <mount_point> [mapper_args]
usage () {
    echo "Usage: $0 <device-uuid-or-path> <mapper_name> <mount_point> [mapper_args]"
    echo "Example: $0 device-uuid my_encrypted /mnt/encrypted --key-file=/root/keyfile"
}

if [ "$#" -lt 3 ]; then
    usage
    exit 1
fi

# Check if its sudo, if not, get sudo permissions
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Attempting to gain sudo permissions..."
    exec sudo "$0" "$@"
fi

DEVICE_UUID="$1"
MAPPER="$2"
MOUNTPOINT="$3"
MAPPER_ARGS=("${@:4}")

# Resolve device path: accept full path, by-uuid or by-partuuid
if [ -b "$DEVICE_UUID" ]; then
    DEVICE_PATH="$DEVICE_UUID"
elif [ -b "/dev/disk/by-uuid/$DEVICE_UUID" ]; then
    DEVICE_PATH="/dev/disk/by-uuid/$DEVICE_UUID"
elif [ -b "/dev/disk/by-partuuid/$DEVICE_UUID" ]; then
    DEVICE_PATH="/dev/disk/by-partuuid/$DEVICE_UUID"
else
    echo "Error: Device $DEVICE_UUID does not exist."
    exit 1
fi

# Check if the mapper name is already in use
if [ -e "/dev/mapper/$MAPPER" ]; then
    echo "Error: Mapper name $MAPPER is already in use."
    exit 1
fi

# Check if the mount point exists
if [ ! -d "$MOUNTPOINT" ]; then
    echo "Error: Mount point $MOUNTPOINT does not exist."
    exit 1
fi

# Attempt to open the encrypted device
if ! cryptsetup open "${MAPPER_ARGS[@]}" "$DEVICE_PATH" "$MAPPER"; then
    echo "Error: Failed to open encrypted device $DEVICE_PATH with mapper name $MAPPER."
    exit 1
fi

# Attempt to mount the decrypted device
if ! mount "/dev/mapper/$MAPPER" "$MOUNTPOINT"; then
    echo "Error: Failed to mount /dev/mapper/$MAPPER to $MOUNTPOINT."
    # Attempt to close the mapper if mounting fails
    cryptsetup close "$MAPPER"
    exit 1
fi

echo "Successfully mounted $DEVICE_PATH to $MOUNTPOINT via mapper $MAPPER."
exit 0