#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]
    then echo "Do not run as root."
    exit
fi

rm -f ~/.config/hypr/display
touch ~/.config/hypr/display
