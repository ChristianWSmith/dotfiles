if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" = "1" ] && [ -z "$DISPLAY" ]
        /usr/bin/sway 2>&1 > /dev/null
    end
    alias "update-package-list" "yay -Qe | cut -d' ' -f1 > ~/.packages"
    alias "update-etc-environment" "cat /etc/environment > ~/.etc-environment"
    alias "shutdown" "systemctl poweroff --no-wall"
    alias "reboot" "systemctl reboot --no-wall --reboot"
end
