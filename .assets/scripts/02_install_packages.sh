#!/bin/bash
set -e

yay -S --needed $(cat ~/.assets/lists/package-list)

yay -Qe | cut -d' ' -f1 > tmp
remove=$(diff tmp ~/.assets/lists/package-list | grep '^>' | sed 's/^>\ //')
yay -R $remove
rm tmp
