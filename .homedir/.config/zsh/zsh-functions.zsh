#!/usr/bin/env zsh
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

# DirStack
alias dir='dirs -v' # List DirStack
for index ({1..9}) alias "$index"="builtin cd +${index} > /dev/null"; unset index # directory stack

d() {
    # Only work with alias d defined in zsh-aliases line 5-6
    dir | fzf --height="20%" | cut -f 1 | source /dev/stdin
}

# bat functions
# bathelp, allows do call help <command> instead of <command> --help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

deltagrep() { # Needs theming
    rg "$@" --json | delta
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
