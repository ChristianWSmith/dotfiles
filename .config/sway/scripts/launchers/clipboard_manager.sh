#!/bin/bash

pkill -x fuzzel

list=$(cliphist list)
if [ "$list" = "" ]
then
    notify-send "The clipboard is empty."
    exit
fi

if [ "$1" = "copy" ]
then
    lines=$(echo "$list" | wc -l)
    echo "$list" | fuzzel --dmenu --prompt="Copy: " --lines $lines | cliphist decode | wl-copy
elif [ "$1" = "delete" ]
then
    lines=$(echo "$list" | wc -l)
    echo "$list" | fuzzel --dmenu --prompt="Delete: " --lines $lines | cliphist delete
elif [ "$1" = "wipe" ]
then
    YES="(Y)es"
    NO="(N)o"
    answer=$(echo -e "$NO\n$YES" | fuzzel --dmenu --lines 2 --prompt="Delete clipboard history? ")
    if [ "$answer" = "$YES" ]
    then
        rm ~/.cache/cliphist/db
    fi
fi
