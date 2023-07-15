#!/bin/bash

PROC_COUNT="$(ps -ef | grep $(basename $0) | grep -v grep | wc -l)"
if [ "$PROC_COUNT" -gt "2" ]
then
    exit
fi

EVENT_ID=$(cat /proc/bus/input/devices | grep "DragonRise" -A 4 | grep "H: Handlers" | cut -d'=' -f2 | cut -d' ' -f1)

xboxdrv_keepalive () {
    while [ -e "/dev/input/${EVENT_ID}" ]
    do
        xboxdrv --evdev /dev/input/${EVENT_ID} --evdev-keymap "BTN_TRIGGER=A,BTN_THUMB2=X,BTN_TOP=Y,BTN_THUMB=B,BTN_PINKIE=LB,BTN_TOP2=RB,BTN_BASE2=LT,BTN_BASE=RT,BTN_BASE5=TL,BTN_BASE6=TR,BTN_BASE3=Back,BTN_BASE4=Start" --evdev-absmap "ABS_X=x1,ABS_Y=y1" --axismap "-y1=y1" --mimic-xpad --silent
    done
}

xboxdrv_keepalive &

inotifywait -e attrib /dev/input/${EVENT_ID}

pkill -9 xboxdrv
