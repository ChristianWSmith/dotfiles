#!/bin/bash

source ~/.config/sway/scripts/helpers/adwaita_colors.sh

blue="#3584e4ff"
red="#c01c28ff"
green="#26a269ff"
yellow="#cd9309ff"
gray="#242424ff"
black="#000000ff"
white="#ffffffff"
transparent="#00000000"

fuzzel --icon-theme=$GTK_ICON_THEME \
    --background-color=$gray \
    --text-color=$white \
    --match-color=$blue \
    --selection-color=$blue \
    --selection-text-color=$white \
    --selection-match-color=$white \
    --border-color=$gray
