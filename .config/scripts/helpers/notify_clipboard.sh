#!/bin/bash

paste=$(wl-paste)

if [ "$paste" ]
then
    notify-send -t 5000 "Clipboard: $paste"
fi
