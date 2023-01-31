if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" -eq 1 ] && [ -z "$DISPLAY" ]
        /usr/bin/sway 2>&1 > /dev/null
    end
    alias "shutdown" "systemctl poweroff --no-wall"
    alias "reboot" "systemctl reboot --no-wall --reboot"
end
