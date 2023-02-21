#!/bin/bash

if rclone listremotes | grep GoogleDrive > /dev/null 2>&1
then
    mkdir -p ~/GoogleDrive
    if cat /etc/mtab | grep GoogleDrive > /dev/null 2>&1
    then
        fusermount -uz ~/GoogleDrive
    fi
    rclone mount GoogleDrive: ~/GoogleDrive & disown
fi
