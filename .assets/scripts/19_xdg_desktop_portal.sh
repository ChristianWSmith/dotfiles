#!/bin/bash

systemctl --user mask xdg-desktop-portal
systemctl --user mask xdg-desktop-portal-wlr
sudo cp ~/.assets/xdg-desktop-portal-install.hook /etc/pacman.d/hooks/xdg-desktop-portal-install.hook
