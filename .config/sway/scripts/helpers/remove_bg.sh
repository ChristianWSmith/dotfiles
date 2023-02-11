#!/bin/bash

current_bg=$($HOME/.config/sway/scripts/helpers/current_swaybg.sh)
file_name=$(basename $current_bg)
rm $current_bg
sed -i "/$file_name/d" ~/.assets/wallpapers.sh
~/.config/sway/scripts/launchers/swaybg.sh > /dev/null 2>&1

