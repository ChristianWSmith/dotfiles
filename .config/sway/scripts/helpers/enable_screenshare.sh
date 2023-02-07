systemctl --user unmask xdg-desktop-portal
systemctl --user unmask xdg-desktop-portal-wlr
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-wlr
systemctl --user mask xdg-desktop-portal
systemctl --user mask xdg-desktop-portal-wlr
