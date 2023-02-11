#!/usr/bin/fish

grim -g $(slurp -d) - | wl-copy
~/.config/scripts/helpers/notify_clipboard.sh
