#!/bin/bash

if ! rclone listremotes | grep GoogleDrive > /dev/null 2>&1
then
    mkdir -p ~/GoogleDrive
    rclone config create GoogleDrive drive
    ~/.config/scripts/helpers/mount_google_drive.sh
fi
