#!/bin/bash

if [ $# != 1 ]
  then
    echo "Provide target image Debian image"
fi

TEMP_DIR="$(mktemp -d $(pwd)/temp-XXX)"

SECTOR_SIZE="$(fdisk -l $1 | grep "Sector size" | awk '{ print $4 }')"

ROOTFS_START_SECTOR="$(fdisk -l $1 | grep "Linux filesystem" | awk '{ print $2 }')"

let "ROOTFS_OFFSET = $SECTOR_SIZE * $ROOTFS_START_SECTOR"

echo $SECTOR_SIZE
echo $ROOTFS_START_SECTOR
echo $ROOTFS_OFFSET

mount -o rw,loop,offset=$ROOTFS_OFFSET $1 ./mnt


