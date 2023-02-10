#!/bin/bash

sleep 0.1
hyprpicker | tr -d '\n' | wl-copy
~/.config/scripts/helpers/notify_clipboard.sh
