# ~/.config/fish/functions/sudo.fish
# Drop-in sudo replacement that injects Wayland/display env for GUI apps.
# Usage is identical to normal sudo — just use sudo as you always would.

function sudo
    # Detect if the target command is a GUI app (needs display env)
    # We always inject — harmless for CLI apps, essential for GUI ones.
    set -l wayland_env \
        "WAYLAND_DISPLAY=$WAYLAND_DISPLAY" \
        "DISPLAY=$DISPLAY" \
        "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
        "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" \
        "XDG_SESSION_TYPE=$XDG_SESSION_TYPE" \
        "QT_QPA_PLATFORM=$QT_QPA_PLATFORM" \
        "GDK_BACKEND=$GDK_BACKEND" \
        "XAUTHORITY=$XAUTHORITY"

    # Filter out any empty vars so we don't pass VAR= noise
    set -l clean_env
    for entry in $wayland_env
        # Only include if value part (after =) is non-empty
        set -l val (string split -m1 '=' -- $entry)[2]
        if test -n "$val"
            set -a clean_env $entry
        end
    end

    # If called as "sudo -E ..." or "sudo --preserve-env ...", just passthrough
    # Otherwise inject our env vars via "sudo env VAR=val ... cmd"
    switch "$argv[1]"
        case '-E' '--preserve-env' '--preserve-env=*'
            command sudo $argv
        case '*'
            command sudo env $clean_env $argv
    end
end
