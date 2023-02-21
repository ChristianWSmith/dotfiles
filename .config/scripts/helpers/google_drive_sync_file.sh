#!/bin/bash

LOCAL_FILE="$1"
ABSOLUTE_LOCAL_PATH=$(readlink -f "${LOCAL_FILE}")
LOCAL_FILE_NAME=$(basename "${ABSOLUTE_LOCAL_PATH}")
LOCAL_DIR=$(dirname "${ABSOLUTE_LOCAL_PATH}")
REMOTE_DIR="${HOME}/GoogleDrive/linux/${LOCAL_DIR}"
ABSOLUTE_REMOTE_PATH="${REMOTE_DIR}/${LOCAL_FILE_NAME}"

if ! test -f "${ABSOLUTE_LOCAL_PATH}"
then
    echo "ERROR: File does not exist."
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
mv "${ABSOLUTE_LOCAL_PATH}" "${ABSOLUTE_REMOTE_PATH}"
ln -sf "${ABSOLUTE_REMOTE_PATH}" "${ABSOLUTE_LOCAL_PATH}"
