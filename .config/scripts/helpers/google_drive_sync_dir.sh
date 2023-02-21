#!/bin/bash

LOCAL_DIR="$1"
REMOTE_DIR="${HOME}/GoogleDrive/linux/${LOCAL_DIR}"

if ! cd "$LOCAL_DIR"
then
    echo "ERROR: Directory does not exist."
    exit 1
fi

if ! cat /etc/mtab | grep GoogleDrive > /dev/null 2>&1
then
    ~/.config/scripts/helpers/mount_google_drive.sh
    if ! cat /etc/mtab | grep GoogleDrive > /dev/null 2>&1
    then
        echo "ERROR: Failed to mount Google Drive."
        exit 1
    fi
fi

mkdir -p "${REMOTE_DIR}"

for local_file in $(cd "$LOCAL_DIR"; find . -type f | cut -d'/' -f2)
do
    mv "${LOCAL_DIR}/${local_file}" "${REMOTE_DIR}/${local_file}"
done

for remote_file in $(cd "$REMOTE_DIR"; find . -type f | cut -d'/' -f2)
do
    ln -sf "${REMOTE_DIR}/${remote_file}" "${LOCAL_DIR}/${remote_file}"
done

for link_file in $(cd "$LOCAL_DIR"; find . -type l | cut -d'/' -f2)
do
    if [ ! -e "$link_file" ] ; then
        unlink "${LOCAL_DIR}/$link_file"
    fi
done
