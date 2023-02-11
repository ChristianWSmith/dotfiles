#!/bin/bash

BEMOJI_PICKER_CMD="$HOME/.config/sway/scripts/helpers/new_fuzzel.sh --dmenu" /usr/bin/bemoji -n
notify-send -t 5000 "Emoji copied to clipboard: $(wl-paste)"
