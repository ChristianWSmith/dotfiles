#!/bin/bash

pkill -x swaybg
backgrounds=(~/.wallpapers/*)

if [ "$backgrounds" != "$HOME/.wallpapers/*" ]
then
	background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
	swaybg -m fill -i $background &
fi
