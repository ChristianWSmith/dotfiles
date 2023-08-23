#!/usr/bin/env bash

pkill hyprpaper
pkill eww
nohup ~/.config/scripts/launchers/waybar.sh hyprland &
nohup hyprpaper &
