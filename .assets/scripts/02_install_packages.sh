#!/bin/bash
set -e

yay -S --needed $(cat ~/.assets/lists/package-list)

yay -Qe > tmp
remove=$(diff ~/.assets/lists/package-list tmp | grep '^>' | sed 's/^>\ //')
yay -R $(remove)
rm tmp
