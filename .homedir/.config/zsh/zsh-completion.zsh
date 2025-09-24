#!/usr/bin/env zsh
# Setting up Completion for ZSH

# Source more completions
fpath=(~/minfiles/submodules/zsh-completions/src $fpath)
fpath=(~/minfiles/.homedir/.config/zsh/completions $fpath)

zmodload zsh/complist #Should be called before compinit

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

# Load completion function and execute. Only update Cache once a day
autoload -Uz compinit
if [ "$(fd --hidden --changed-before 6h --base-directory $XDG_CACHE_HOME .zcompdump)" ] ; then # Update Compdump every 6h
    compinit -d "${XDG_CACHE_HOME}/.zcompdump"
else
    compinit -C -d "${XDG_CACHE_HOME}/.zcompdump"
fi
_comp_options+=(globdots) # Include hidden files

# Set some options
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# Style of Completion
# Zstyle Pattern: :completion:<function>:<completer>:<command>:<argument>:<tag>

zstyle ':completion:*' completer _extensions _complete _approximate # Completers

# Enable Cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete aliases with _expand_alias
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

zstyle ':completion:*' menu select # Menu selection of Tab complete

zstyle ':completion:*' complete-options true # autocomplete for cd instead of dir stack

zstyle ':completion:*' file-sort modification # Sort files by modification Time

# Styling
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
