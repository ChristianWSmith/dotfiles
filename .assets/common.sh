#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]
    then echo "Do not run as root."
    exit
fi

for script in $(ls ~/.assets/scripts)
do
    echo "+ $script"
    ~/.assets/scripts/$script
    echo "- $script"
done
