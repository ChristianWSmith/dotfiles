#!/bin/bash

ps -ef | grep "alternating_layout.py" | grep -v "grep" | \
while read ps_line
do
    pid=$(echo $ps_line | cut -d' ' -f2)
    if [ "$pid" != "" ]
    then
        kill -9 $pid
    fi
done

~/.config/sway/scripts/alternating_layout.py &
