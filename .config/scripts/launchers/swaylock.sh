#!/bin/bash

pkill -x swaylock

image=$(~/.config/scripts/helpers/current_swaybg.sh)

if [ "$image" = "" ]
then
    image=$(~/.config/scripts/helpers/random_bg.sh)
fi

tmp_image=/tmp/$(basename $image)

if [ ! -e $tmp_image ]
then
    : # Use this if we want to apply image effects to the lock screen
    # cp $image $tmp_image
    # convert $image -blur 7x5 $tmp_image
fi

swaylock --image $image # you would use tmp_image here if applying effects
~/.config/scripts/helpers/bell.sh
