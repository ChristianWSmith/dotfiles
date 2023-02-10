#!/usr/bin/fish

grim -g $(slurp -d) - | wl-copy
notify-send -t 5000 "Screenshot copied to clipboard."
