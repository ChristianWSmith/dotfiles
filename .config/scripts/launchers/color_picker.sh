#!/bin/bash

hyprpicker | tr -d '\n' | wl-copy
~/.config/scripts/helpers/notify_clipboard.sh
