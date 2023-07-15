#!/bin/bash

if [ $(ps -ef | grep $(basename $0) | grep -v grep | wc -l) -gt 2 ]
then
    exit
fi

xboxdrv_keepalive () {
    while [ -e /dev/input/$1 ]
    do
        xboxdrv --evdev /dev/input/$1 --evdev-keymap "BTN_TRIGGER=A,BTN_THUMB2=X,BTN_TOP=Y,BTN_THUMB=B,BTN_PINKIE=LB,BTN_TOP2=RB,BTN_BASE2=LT,BTN_BASE=RT,BTN_BASE5=TL,BTN_BASE6=TR,BTN_BASE3=Back,BTN_BASE4=Start" --evdev-absmap "ABS_X=x1,ABS_Y=y1" --axismap "-y1=y1" --mimic-xpad --silent
    done
}


while true
do
    EVENT_ID=$(cat /proc/bus/input/devices | grep "DragonRise" -A 4 | grep "H: Handlers" | cut -d'=' -f2 | cut -d' ' -f1)

    if [[ ! -z "$EVENT_ID" ]]
    then
        xboxdrv_keepalive $EVENT_ID &
        inotifywait -e attrib /dev/input/${EVENT_ID}
        pkill -9 xboxdrv
    fi

    inotifywait -e create /dev/input
    sleep 1
done

