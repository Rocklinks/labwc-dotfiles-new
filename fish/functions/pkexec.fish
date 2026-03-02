# ~/.config/fish/functions/pkexec.fish
# Drop-in pkexec replacement that injects Wayland/display env for GUI apps.

function pkexec
    set -l wayland_env \
        "WAYLAND_DISPLAY=$WAYLAND_DISPLAY" \
        "DISPLAY=$DISPLAY" \
        "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
        "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" \
        "XDG_SESSION_TYPE=$XDG_SESSION_TYPE" \
        "QT_QPA_PLATFORM=$QT_QPA_PLATFORM" \
        "GDK_BACKEND=$GDK_BACKEND" \
        "XAUTHORITY=$XAUTHORITY"

    set -l clean_env
    for entry in $wayland_env
        set -l val (string split -m1 '=' -- $entry)[2]
        if test -n "$val"
            set -a clean_env $entry
        end
    end

    command pkexec env $clean_env $argv
end
