#!/bin/bash

POWER_PROFILE=~/.power_profile
POWER_SAVER="power-saver"
BALANCED="balanced"
PERFORMANCE="performance"

do_update=1

if [ "$1" = "$POWER_SAVER" ]
then
    notify-send --icon=~/.local/share/icons/leaf.svg -t 5000 "Power profile set to saver."
    powerprofilesctl set $POWER_SAVER &
    text=""
    tooltip="Power Profile: Saver "
    internal=$POWER_SAVER
elif [ "$1" = "$BALANCED" ]
then
    notify-send --icon=~/.local/share/icons/scale-balanced.svg -t 5000 "Power profile set to balanced."
    powerprofilesctl set $BALANCED &
    text=""
    tooltip="Power Profile: Balanced "
    internal=$BALANCED
elif [ "$1" = "$PERFORMANCE" ]
then
    notify-send --icon=~/.local/share/icons/bolt.svg -t 5000 "Power profile set to performance."
    powerprofilesctl set $PERFORMANCE &
    text=""
    tooltip="Power Profile: Performance "
    internal=$PERFORMANCE
else
    notify-send -t 5000 "Requested power profile not recognized."
    do_update=0
fi

tooltip="${tooltip}\nLeft Click: Saver\nMiddle Click: Balanced\nRight Click: Performance"

if [ $do_update -eq 1 ]
then
    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"internal\": \"$internal\"}" > $POWER_PROFILE
fi
