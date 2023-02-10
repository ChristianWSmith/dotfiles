#!/bin/bash

pkill -x swaylock

image=$(~/.config/scripts/helpers/current_swaybg.sh)

if [ "$image" = "" ]
then
    image=$(~/.config/scripts/helpers/random_bg.sh)
fi

swaylock --image $image
