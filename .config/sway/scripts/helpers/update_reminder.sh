#!/bin/bash

if [ "$(checkupdates)" ] || [ "$(checkupdates-aur)" ]
then
    notify-send -t 5000 "Updates needed."
    echo ""
else
    echo ""
fi
