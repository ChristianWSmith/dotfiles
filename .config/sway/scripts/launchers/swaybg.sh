#!/bin/bash

pkill -x swaybg
backgrounds=($(find ~/.wallpapers -type f | tr ' ' '\n'))


background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
swaybg -m fill -i $background &
