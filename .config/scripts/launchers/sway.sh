#!/bin/bash

export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_PLUGINS_PATH=/usr/lib/qt/plugins/
export GTK_THEME=Adw-dark
export GTK_ICON_THEME=Papirus-Dark
export EDITOR=vim
export WEB_BROWSER=google-chrome-stable
export GUI_FILE_BROWSER=nemo
export TUI_FILE_BROWSER=ranger
export TERMINAL=footclient
export TUI_TASK_MANAGER=btop
export TUI_NETWORK_MANAGER=nmtui
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME=$HOME/.config
export TUI_VOLUME_CONTROL=pulsemixer
export GUI_VOLUME_CONTROL=pavucontrol

dbus-run-session sway
