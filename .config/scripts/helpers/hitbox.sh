#!/bin/bash

xboxdrv --evdev /dev/input/event24 --evdev-keymap "BTN_TRIGGER=A,BTN_THUMB2=X,BTN_TOP=Y,BTN_THUMB=B,BTN_PINKIE=LB,BTN_TOP2=RB,BTN_BASE2=LT,BTN_BASE=RT,BTN_BASE5=TL,BTN_BASE6=TR,BTN_BASE3=Back,BTN_BASE4=Start" --evdev-absmap "ABS_X=x1,ABS_Y=y1" --axismap "-y1=y1" --mimic-xpad --silent
