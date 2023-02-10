#!/bin/bash

LOCK=" (L)ock"
REBOOT=" (R)eboot"
SHUTDOWN=" (S)hutdown"

result=$(echo -e "$LOCK\n$REBOOT\n$SHUTDOWN" | ~/.config/scripts/helpers/new_fuzzel.sh --dmenu --lines 3)

if [ "$result" = "$LOCK" ]
then
    gtklock
elif [ "$result" = "$REBOOT" ]
then
    systemctl reboot --no-wall
elif [ "$result" = "$SHUTDOWN" ]
then
    systemctl poweroff --no-wall
fi
