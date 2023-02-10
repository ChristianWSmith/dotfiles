#!/bin/bash

hyprpicker | tr -d '\n' | wl-copy
if [ "$(wl-paste)" ]
then
    notify-send -t 5000 "Color code copied to clipboard: $(wl-paste)"
else
    notify-send -t 5000 "No color copied to clipboard."
fi
