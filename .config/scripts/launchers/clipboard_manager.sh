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
    echo "$list" | ~/.config/scripts/helpers/new_fuzzel.sh --dmenu --prompt="Copy: " --lines $lines | cliphist decode | wl-copy
    ~/.config/scripts/helpers/notify_clipboard.sh
elif [ "$1" = "delete" ]
then
    lines=$(echo "$list" | wc -l)
    echo "$list" | ~/.config/scripts/helpers/new_fuzzel.sh --dmenu --prompt="Delete: " --lines $lines | cliphist delete
elif [ "$1" = "wipe" ]
then
    YES="(Y)es"
    NO="(N)o"
    answer=$(echo -e "$NO\n$YES" | ~/.config/scripts/helpers/new_fuzzel.sh --dmenu --lines 2 --prompt="Delete clipboard history? ")
    if [ "$answer" = "$YES" ]
    then
        rm ~/.cache/cliphist/db
        notify-send -t 5000 "Clipboard wiped."
    fi
fi
