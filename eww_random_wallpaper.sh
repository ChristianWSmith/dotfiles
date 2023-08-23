#!/usr/bin/env bash

unlink ~/.wallpapers/active; ln -s $(echo ~/.wallpapers/nature/$(ls ~/.wallpapers/nature/ | sort -R | tail -1)) ~/.wallpapers/active; eww reload
