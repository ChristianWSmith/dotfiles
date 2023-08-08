#!/bin/bash

POWER_PROFILE=~/.power_profile

# if [ -e

touch $POWER_PROFILE

CURRENT_MODE=$(powerprofilesctl list | grep "*" | cut -d' ' -f2 | cut -d':' -f1)

if [ "$CURRENT_MODE" = "performance" ]
then
    notify-send -t 5000 "Power profile set to saver."
    powerprofilesctl set power-saver &
    text=""
    tooltip="Saver"
elif [ "$CURRENT_MODE" = "power-saver" ]
then
    notify-send -t 5000 "Power profile set to balanced."
    powerprofilesctl set balanced &
    text=""
    tooltip="Balanced"
elif [ "$CURRENT_MODE" = "balanced" ]
then
    notify-send -t 5000 "Power profile set to performance."
    powerprofilesctl set performance &
    text=""
    tooltip="Performance"
else
    notify-send -t 5000 "Power profile not detected."
    text=""
    tooltip="Power profile not detected."
fi
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}" > $POWER_PROFILE

