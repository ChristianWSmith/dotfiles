#!/bin/bash

layout_scripts=(~/.config/sway/scripts/layouts/*)


for layout_script in ${layout_scripts[@]}
do
    script_name=$(basename $layout_script)
    ps -ef | grep $script_name | grep -v "grep" | \
    while read ps_line
    do
        pid=$(echo $ps_line | cut -d' ' -f2)
        if [ "$pid" != "" ]
        then
            kill -9 $pid
        fi
    done
done
