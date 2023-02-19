#!/bin/bash

mkdir -P ~/.local/share/dolphin-emu/Styles
mkdir -P ~/.config/dolphin-emu
wget -O ~/.local/share/dolphin-emu/Styles/lightsout.qss "https://raw.githubusercontent.com/Humanoidear/Lightsout/main/Lightsout/Lightsout_V.2.0%20(dark).qss"

omit=false

if ! test -f ~/.config/dolphin-emu/Qt.ini
then
    exit
fi

rm tmp
touch tmp

while read line; do
  if $omit 
  then
    if [ "${line:0:1}" = "[" ]
    then
        omit=false
        echo $line >> tmp
    fi
  else
    if [ "$line" = "[userstyle]" ]
    then
        omit=true
    else
        echo $line >> tmp
    fi
  fi
done < ~/.config/dolphin-emu/Qt.ini

echo "" >> tmp
echo [userstyle] >> tmp
echo enabled=true >> tmp
echo name=lightsout.qss >> tmp

mv tmp ~/.config/dolphin-emu/Qt.ini
