#!/usr/bin/env zsh
function detect_terminal_theme() {
    emulate -L zsh

    local response
    local oldstty
    local r g b brightness

    exec </dev/tty

    oldstty=$(stty -g)
    stty raw -echo min 0 time 0

    printf '\033]11;?\007' >/dev/tty

    sleep 0.1

    response=$(dd bs=1 count=64 2>/dev/null)

    stty "$oldstty"

    # Extract full 16-bit RGB values
    if [[ $response =~ 'rgb:([0-9a-fA-F]{4})/([0-9a-fA-F]{4})/([0-9a-fA-F]{4})' ]]; then
        r=$((16#${match[1]}))
        g=$((16#${match[2]}))
        b=$((16#${match[3]}))

        # Scale 16-bit -> 8-bit
        r=$((r / 257))
        g=$((g / 257))
        b=$((b / 257))

        brightness=$(((r + g + b) / 3))

        if ((brightness < 128)); then
            echo dark
        else
            echo light
        fi
    else
        echo unknown
    fi
}

function mambas() {
    environments=$(mamba env list | tail -n +4 | cut -d ' ' -f 3)
    items=("base" "deactivate" "$environments")
    # config for fuzzy finder selection window
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt="🐍 Mamba Config >> " --height=50% --info=inline --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        mambastatus="Changed Nothing"
    elif [[ $config == "deactivate" ]]; then
        mamba deactivate
        mambastatus="Deactivated"
    else
        mamba activate "$config"
        mambastatus="Activated $config"
    fi
    printf "%s\n" "$mambastatus"
    echo # final newline to show status in shell
    zle accept-line
}
zle -N mambas

function yazicdonquit() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function profileZSH() {
    zmodload zsh/zprof
    source ~/.config/zsh/.zshrc
    zprof
}
zle -N profileZSH

function cpv() {
    rsync -brav -hhh --backup-dir="/tmp/rsync-${USERNAME}" -e /dev/null --progress "$@"
}
compdef _files cpv

function fzf-change-dirstack() {
    local ldir=$(dirs -v | tail -n +2 | fzf --height="20%" --header="current: $(pwd)" | cut -f 1)
    cd -- "+$ldir" >/dev/null
    unset ldir
}
zle -N fzf-change-dirstack

# bat functions
# bathelp, allows do call help <command> instead of <command> --help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

function set_delta_features() {
    local theme
    if [[ "$(detect_terminal_theme)" == "light" ]]; then
        theme="catppucin-latte"
    else
        theme="catppuccin-mocha"
    fi
    export DELTA_FEATURES="${theme} decorations"
}

function git() {
    set_delta_features
    command git "$@"
}

function deltagrep() {
    set_delta_features
    command rg "$@" --json | delta
}

# lazygit
function lazygit() {
    local theme
    if [[ "$(detect_terminal_theme)" == "light" ]]; then
        theme="latte"
    else
        theme="mocha"
    fi
    command lazygit --use-config-file="${XDG_CONFIG_HOME}/lazygit/config.yml,${XDG_CONFIG_HOME}/lazygit/${theme}-sapphire.yml"
}

# Package functions
bremove() { # List installed packages
    pacman -Qq | fzf --multi --reverse --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -R
}

remove() {
    yay -Qq | fzf --multi --reverse --preview 'yay -Qi {1}' | xargs -ro yay -R
}

binstall() { # Search for packages
    pacman -Slq | fzf --multi --reverse --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Sy
}

install() {
    yay -Slq | fzf --multi --reverse --preview 'yay -Si {1}' | xargs -ro yay -Sy
}
