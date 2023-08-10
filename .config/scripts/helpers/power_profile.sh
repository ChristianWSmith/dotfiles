#!/bin/bash

POWER_PROFILE=~/.power_profile
POWER_SAVER="power-saver"
BALANCED="balanced"
PERFORMANCE="performance"

do_update=1

if [ "$1" = "$POWER_SAVER" ]
then
    icon=power-profile-power-saver-symbolic
    text=""
    tooltip="Power Profile: Saver "
    internal=$POWER_SAVER
elif [ "$1" = "$BALANCED" ]
then
    icon=power-profile-balanced-symbolic
    text=""
    tooltip="Power Profile: Balanced "
    internal=$BALANCED
elif [ "$1" = "$PERFORMANCE" ]
then
    icon=power-profile-performance-symbolic
    text=""
    tooltip="Power Profile: Performance "
    internal=$PERFORMANCE
else
    notify-send -t 5000 "Requested power profile not recognized."
    do_update=0
fi


if [ $do_update -eq 1 ]
then
    if powerprofilesctl set $internal
    then
        notify-send --icon=$icon -t 5000 "Set $tooltip"
        tooltip="${tooltip}\nLeft Click: Saver\nMiddle Click: Balanced\nRight Click: Performance"
        echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}" > $POWER_PROFILE
    else
        notify-send --urgency="critical" -t 5000 "Failed to set $tooltip"
    fi
fi
