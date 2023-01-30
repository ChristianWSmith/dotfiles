if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" -eq 1 ] && [ -z "$DISPLAY" ]
        /usr/bin/sway 2>&1 >> ~/.sway.log
    end
end
