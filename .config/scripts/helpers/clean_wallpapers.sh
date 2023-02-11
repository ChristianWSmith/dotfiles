#!/bin/bash

for file in $(find ~/.wallpapers -type f)
do
    dimensions=$(identify $file | cut -d' ' -f3)
    width=$(echo $dimensions | cut -d'x' -f1)
    height=$(echo $dimensions | cut -d'x' -f2)
    if [ $width -lt 1920 ] || [ $height -lt 1080 ]
    then
        echo "removing $file ($dimensions)"
        rm $file
        file_name=$(basename $file)
        sed -i "/$file_name/d" ~/.wallpapers.sh
    fi
done
