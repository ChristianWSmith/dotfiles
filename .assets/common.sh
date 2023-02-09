#!/bin/bash

if [ "$EUID" -eq 0 ]
    then echo "Do not run as root."
    exit
fi

for script in $(ls ~/.assets/scripts)
do
    ~/.assets/scripts/$script
done
