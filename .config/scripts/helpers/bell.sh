#!/bin/bash


if [ "$1" = "blocking" ]
then
    aplay ~/.assets/sound/bell.wav
else
    aplay ~/.assets/sound/bell.wav &
fi
