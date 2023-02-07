#!/bin/bash

touch ~/.update_reminder
while true
do
    if [ "$(checkupdates)" ] || [ "$(checkupdates-aur)" ]
    then
        notify-send -t 5000 "Updates required."
        text=""
        tooltip="Updates required."
    else
        text=""
        tooltip="Up to date."
    fi
    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}" > ~/.update_reminder
    sleep 3600
done
