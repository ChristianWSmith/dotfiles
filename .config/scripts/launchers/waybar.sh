#!/bin/bash

pkill -x waybar

if [ "$1" = "sway" ]
then
    waybar -c ~/.config/waybar/config_sway -s ~/.config/waybar/style.css &
elif [ "$1" = "hyprland" ]
then
    waybar -c ~/.config/waybar/config_hyprland -s ~/.config/waybar/style.css &
fi
