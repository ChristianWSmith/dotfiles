#!/bin/bash

pkill -x swaylock

image=$(readlink $HOME/.wallpapers/active.png)

tmp_image=/tmp/$(basename $image)

if [ ! -e $tmp_image ]
then
    # Use this if we want to apply image effects to the lock screen
    convert $image -blur 7x5 $tmp_image
fi

swaylock --image $tmp_image # you would use tmp_image here if applying effects
~/.config/scripts/helpers/bell.sh
