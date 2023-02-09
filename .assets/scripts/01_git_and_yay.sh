#!/bin/bash
set -e

if ! which git > /dev/null 2>&1
then
    sudo pacman -S git
fi
if ! which yay > /dev/null 2>&1
then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi
