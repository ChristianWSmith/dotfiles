#!/bin/bash
set -e

REPO_LIST=$HOME/.assets/lists/package-list
TEMP_LIST=/tmp/package-list

yay -Qe | cut -d' ' -f1 | sort > $TEMP_LIST

yay -S --needed $(comm -13 $REPO_LIST $TEMP_LIST)

remove=$(comm -23 $REPO_LIST $TEMP_LIST)
if [ "$remove" ]
then
    yay -R $remove
fi
rm tmp

sudo rm /usr/share/applications/steam-native.desktop
