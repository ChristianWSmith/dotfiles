#!/bin/bash

backgrounds=($(find ~/.wallpapers -type f | tr ' ' '\n'))
if [ "$backgrounds" != "" ]
then
    background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
    echo $background
fi
