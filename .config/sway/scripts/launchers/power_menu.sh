#!/bin/bash

pkill -x fuzzel

LOCK=" (L)ock"
REBOOT=" (R)eboot"
SHUTDOWN=" (S)hutdown"

result=$(echo -e "$LOCK\n$REBOOT\n$SHUTDOWN" | fuzzel --dmenu --lines 3)

if [ "$result" = "$LOCK" ]
then
    ~/.config/sway/scripts/launchers/swaylock.sh
elif [ "$result" = "$REBOOT" ]
then
    systemctl reboot --no-wall
elif [ "$result" = "$SHUTDOWN" ]
then
    systemctl poweroff --no-wall
fi
