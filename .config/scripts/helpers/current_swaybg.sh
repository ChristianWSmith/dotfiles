#!/bin/bash

swaybg_file=""
for ps_token in $(ps -ef | grep swaybg)
do
    if test -f $ps_token
    then
        swaybg_file=$ps_token
        break
    fi
done
echo $swaybg_file
