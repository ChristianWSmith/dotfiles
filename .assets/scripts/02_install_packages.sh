#!/bin/bash
set -e

yay -S --needed $(cat ~/.assets/lists/package-list)

yay -Qe | cut -d' ' -f1 > tmp
remove=$(diff ~/.assets/lists/package-list tmp | grep '^>' | sed 's/^>\ //')
if [ "$remove" ]
then
    yay -R $remove
fi
rm tmp
