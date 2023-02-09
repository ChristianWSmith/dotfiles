#!/bin/bash
set -e

systemctl --user mask xdg-desktop-portal
systemctl --user mask xdg-desktop-portal-wlr
sudo cp ~/.assets/hooks/xdg-desktop-portal-install.hook /etc/pacman.d/hooks/xdg-desktop-portal-install.hook
