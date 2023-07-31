#!/bin/bash

if [ "$1" = "sway" ]
then
    systemctl --user unmask xdg-desktop-portal
    systemctl --user unmask xdg-desktop-portal-wlr
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user start xdg-desktop-portal
    systemctl --user start xdg-desktop-portal-wlr
    systemctl --user mask xdg-desktop-portal
    systemctl --user mask xdg-desktop-portal-wlr
elif [ "$1" = "hyprland" ]
then
    systemctl --user unmask xdg-desktop-portal
    systemctl --user unmask xdg-desktop-portal-hyprland
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user start xdg-desktop-portal
    systemctl --user start xdg-desktop-portal-hyprland
    systemctl --user mask xdg-desktop-portal
    systemctl --user mask xdg-desktop-portal-hyprland
fi
