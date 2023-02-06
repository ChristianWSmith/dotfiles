#!/bin/bash

if [ "$(checkupdates)" ] || [ "$(checkupdates-aur)" ]
then
    notify-send -t 5000 "Updates needed."
    text=""
    tooltip="Updates required."
else
    text=""
    tooltip="Up to date."
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
