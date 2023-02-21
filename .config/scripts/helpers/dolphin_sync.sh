#!/bin/bash

LOCAL_DIR="$HOME/.local/share/dolphin-emu/GC/USA/Card A"
REMOTE_DIR="$HOME/GoogleDrive/home/.local/share/dolphin-emu/GC/USA/Card A"

if ! cd "$LOCAL_DIR" || ! cd "$REMOTE_DIR"
then
    echo "ERROR: One or both directories don't exist."
    exit 1
fi

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
