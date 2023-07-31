#!/bin/bash

for file in $(yay -Ql hyprland | grep png | cut -d' ' -f2)
do
    dimensions=$(identify -format '%wx%h' $file)
    sudo convert -size $dimensions xc:black $file
done
