#!/bin/bash

echo "Updating..."
yay --sync --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake
read -p "Press any key to continue..."
