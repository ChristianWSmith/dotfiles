#!/bin/bash

echo "Updating..."
yay -Syu --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake
read -p "Press any key to continue..."
