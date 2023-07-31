#!/bin/bash

if pgrep waybar 2>&1 > /dev/null;
then
    pkill waybar
    if [ "$1" = "hyprland" ]
    then
        hyprctl keyword general:gaps_in 0
        hyprctl keyword general:gaps_out 0
        hyprctl keyword general:border_size 0
        hyprctl keyword decoration:rounding 0
    fi
else
    ~/.config/scripts/launchers/waybar.sh $1
    if [ "$1" = "hyprland" ]
    then
        hyprctl keyword general:gaps_in 6
        hyprctl keyword general:gaps_out 18
        hyprctl keyword general:border_size 3
        hyprctl keyword decoration:rounding 10
    fi
fi
