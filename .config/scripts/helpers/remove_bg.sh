#!/bin/bash

current_bg=$($HOME/.config/scripts/helpers/current_swaybg.sh)
file_name=$(basename $current_bg)
rm $current_bg
sed -i "/$file_name/d" ~/.assets/scripts/*_wallpapers.sh
~/.config/scripts/launchers/swaybg.sh > /dev/null 2>&1

