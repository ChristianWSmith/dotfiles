#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]
    then echo "Do not run as root."
    exit
fi

rm -f ~/.config/hypr/display.conf
/bin/bash -c 'tee -a ~/.config/hypr/display.conf <<EOF
monitor=,preferred,auto,auto
EOF' > /dev/null

rm -f ~/.config/sway/display
touch ~/.config/sway/display
