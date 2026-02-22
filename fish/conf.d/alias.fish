alias install="sudo pacman -S --noconfirm --disable-download-timeout"
alias uninstall="sudo pacman -Rcns --noconfirm"
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"
alias enable="sudo systemctl enable"
alias disable="sudo systemctl disable"
alias sstatus="sudo systemctl status"
alias search="sudo pacman -Qs"
alias update="sudo pacman -Syu --noconfirm --disable-download-timeout"
alias clean="sudo pacman -Scc --noconfirm; yay -Scc --noconfirm; sudo paccache -r"
alias c="clear"
alias fastfetch="fastfetch"

function sudo
    command sudo env \
        WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
        DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
        $argv
end


function pkexec
    command pkexec env \
        WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
        DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
        $argv
end

