#!/bin/bash

pkill -x swaylock

swaylock_command="swaylock -s fill -i"

swaybg_file=""
for ps_token in $(ps -ef | grep swaybg)
do
    if test -f $ps_token
    then
        swaybg_file=$ps_token
        break
    fi
done

if [ "$swaybg_file" != "" ]
then
    $swaylock_command $swaybg_file &
else
    backgrounds=(~/.config/sway/backgrounds/*)

    if [ "$backgrounds" != "" ]
    then
        background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
        $swaylock_command $background &
    else
        swaylock &
    fi
fi
