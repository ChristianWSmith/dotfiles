#!/bin/bash

URL=$1
DIR=$PWD/$2

mkdir -p $DIR
mkdir -p $DIR/video
mkdir -p $DIR/audio

cd $DIR/video
while ! youtube-dl $URL; do :; done
~/.config/scripts/helpers/clean_names.sh $DIR/video
cd ..

for video_file in $DIR/video/*
do
    audio_file=$DIR/audio/$(basename "$(echo $video_file | rev | cut -d'.' -f2- | rev).mp3")
    echo $video_file
    echo $audio_file
    if [ -z ${audio_file} ]
    then
        if ffmpeg -i "${video_file}" -vn -ab 128k -ar 48000 -y "${audio_file}"
        then
            echo rm $video_file
        fi
    fi
done

if [ ! "$(ls -A $DIR/video)" ]
then
    rm -rf $DIR/video
    mv $DIR/audio/* $DIR/
    rm -rf $DIR/audio
fi
