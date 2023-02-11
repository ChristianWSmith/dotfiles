#!/bin/bash

hyprpicker | tr -d '\n' | wl-copy
notify-send -t 5000 "Color code copied to clipboard: $(wl-paste)"
