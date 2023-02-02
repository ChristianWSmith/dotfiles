if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" = "1" ] && [ -z "$DISPLAY" ]
        /usr/bin/sway 2>&1 > /dev/null
    end
    fish_add_path ~/.local/bin
    alias "update-package-list" "yay -Qe | cut -d' ' -f1 > ~/.packages"
    alias "update-etc-environment" "cat /etc/environment > ~/.etc-environment"
    alias "update-pip-list" "pip list | tail -n +3 | cut -d' ' -f1 > ~/.pip-list"
    alias "shutdown" "systemctl poweroff --no-wall"
    alias "reboot" "systemctl reboot --no-wall --reboot"
    alias "baseline" "sudo timeshift --delete-all; sudo timeshift --create --comments 'base'"
end
