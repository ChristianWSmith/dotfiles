#!/bin/bash

text=""
alt=""
tooltip=""
class=""
percentage=""

if [ "$1" = "clipboard" ]
then
    text=""
    tooltip=""
elif [ "$1" = "screenshot" ]
then
    text=""
    tooltip=""
elif [ "$1" = "colorpicker" ]
then
    text=""
    tooltip=""
elif [ "$1" = "emoji" ] 
then
    text=""
    tooltip="Emoji Picker"
elif [ "$1" = "powermenu" ]
then
    text=""
    tooltip=""
fi

echo "{\"text\": \"$text\", \"alt\": \"$alt\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": \"$percentage\"}"
