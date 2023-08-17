#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd ~/.assets/lists/
yay -Qe | cut -d' ' -f1 | sort > package-list-tmp

figlet PACKAGES | lolcat

echo -e "$GREEN"
comm -13 package-list package-list-tmp | sed 's/^/+ /g'

echo -e "$RED"
comm -23 package-list package-list-tmp | sed 's/^/- /g'

echo -e "$NC"
rm package-list-tmp
