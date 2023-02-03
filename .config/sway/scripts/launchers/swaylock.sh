#!/bin/bash

pkill -x swaylock

image=$(~/.config/sway/scripts/helpers/current_swaybg.sh)

if [ "$image" = "" ]
then
    image=$(~/.config/sway/scripts/helpers/random_bg.sh)
fi

swaylock --image $image
