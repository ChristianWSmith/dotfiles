#!/bin/bash

pkill -x swaylock

swaylock_command="swaylock"

swaybg_file=$(~/.config/sway/scripts/helpers/current_swaybg.sh)

if [ "$swaybg_file" != "" ]
then
    swaylock_command="$swaylock_command --image $swaybg_file"
else
    backgrounds=(~/.wallpapers*)
    if [ "$backgrounds" != "" ]
    then
        background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
        swaylock_command="$swaylock_command --image $background"
    fi
fi

$swaylock_command &
