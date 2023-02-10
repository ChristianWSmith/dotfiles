#!/bin/bash

list=$(cliphist list)
if [ "$list" = "" ]
then
    notify-send -t 5000 "The clipboard is empty."
    exit
fi

if [ "$1" = "copy" ]
then
    lines=$(echo "$list" | wc -l)
    echo "$list" | ~/.config/sway/scripts/helpers/new_fuzzel.sh --dmenu --prompt="Copy: " --lines $lines | cliphist decode | wl-copy
    notify-send -t 5000 "Copied to clipboard."
elif [ "$1" = "delete" ]
then
    lines=$(echo "$list" | wc -l)
    echo "$list" | ~/.config/sway/scripts/helpers/new_fuzzel.sh --dmenu --prompt="Delete: " --lines $lines | cliphist delete
    notify-send -t 5000 "Deleted from clipboard."
elif [ "$1" = "wipe" ]
then
    YES="(Y)es"
    NO="(N)o"
    answer=$(echo -e "$NO\n$YES" | ~/.config/sway/scripts/helpers/new_fuzzel.sh --dmenu --lines 2 --prompt="Delete clipboard history? ")
    if [ "$answer" = "$YES" ]
    then
        rm ~/.cache/cliphist/db
        notify-send -t 5000 "Clipboard wiped."
    fi
fi
