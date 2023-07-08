#!/bin/bash

if pgrep waybar 2>&1 > /dev/null;
then
    pkill waybar
else
    ~/.config/scripts/launchers/waybar.sh
fi
