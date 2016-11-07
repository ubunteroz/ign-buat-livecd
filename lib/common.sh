#!/bin/bash

IGN_LIB_LOADED="true"

# Variables
VERSION="0.5"
CREDIT="ubunteroz, IGN-dev"
DATE="$(date '+%F-%H-%M-%S')"
if [[ "$BASE_TEMP_MOUNTPOINT" == "" ]]; then BASE_TEMP_MOUNTPOINT="/tmp/ign-$DATE"; fi
TEMP_ISO_MOUNTPOINT="$BASE_TEMP_MOUNTPOINT/iso"
TEMP_LOS_MOUNTPOINT="$BASE_TEMP_MOUNTPOINT/liveos"
TEMP_RFS_MOUNTPOINT="$BASE_TEMP_MOUNTPOINT/rootfs"

function s_log {
	echo -e "\e[1m\e[33m$1\e[0m"
}

function e_log {
	echo -e "\e[1m\e[31m$1\e[0m"
}

function s_mount_iso {
	sync
	if [ -d "$TEMP_LOS_MOUNTPOINT" ]; then
		umount -l "$TEMP_LOS_MOUNTPOINT"
		rm -rf "$TEMP_LOS_MOUNTPOINT"
	fi
	if [ -d "$TEMP_RFS_MOUNTPOINT" ]; then
		umount -l "$TEMP_RFS_MOUNTPOINT"
		rm -rf "$TEMP_RFS_MOUNTPOINT"
	fi
	if [ -d "$TEMP_ISO_MOUNTPOINT" ]; then
		fusermount -u -z "$TEMP_ISO_MOUNTPOINT"
		rm -rf "$TEMP_ISO_MOUNTPOINT"
	fi

	mkdir -p "$TEMP_ISO_MOUNTPOINT"
	mkdir -p "$TEMP_LOS_MOUNTPOINT"
	mkdir -p "$TEMP_RFS_MOUNTPOINT"

	fuseiso -n "$SOURCE_ISO" "$TEMP_ISO_MOUNTPOINT"
	mount -o ro "$TEMP_ISO_MOUNTPOINT/LiveOS/squashfs.img" "$TEMP_LOS_MOUNTPOINT"

	# Detect rootfs file name
	FILENAME_TO_CHECK="ext3fs.img ext4fs.img rootfs.img"
	for file in $FILENAME_TO_CHECK; do
		if [ -f "$TEMP_LOS_MOUNTPOINT/LiveOS/$file" ]; then
			ROOTFS_NAME="$file"
		fi
	done
	if [[ "$ROOTFS_NAME" != "" ]]; then
		s_log "-> Rootfs ditemukan: $ROOTFS_NAME"
		mount -o ro "$TEMP_LOS_MOUNTPOINT/LiveOS/$ROOTFS_NAME" "$TEMP_RFS_MOUNTPOINT"
	else
		e_log "-> Rootfs tidak ditemukan!"
		sync
		umount -l "$TEMP_LOS_MOUNTPOINT"
		fusermount -u -z "$TEMP_ISO_MOUNTPOINT"
		rm -rf "$BASE_TEMP_MOUNTPOINT"
	fi
}

function s_umount_iso {
	sync
	umount -l "$TEMP_RFS_MOUNTPOINT"
	umount -l "$TEMP_LOS_MOUNTPOINT"
	fusermount -u "$TEMP_ISO_MOUNTPOINT"
	rm -rf "$BASE_TEMP_MOUNTPOINT"
}
