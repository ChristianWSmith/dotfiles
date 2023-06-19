#!/bin/bash

OIFS="$IFS"
IFS=$'\n'
for file in $(find . -maxdepth 1); do 
    res=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$file" 2> /dev/null);
    if [ "$res" != "" ]; then
        mkdir -p $res
        mv "$file" "$res/"
    fi
done
