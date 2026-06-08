#!/usr/bin/env zsh
# Alias definitions

#cd aliases
alias ..='builtin cd ..'
alias ...='builtin cd ../..'
alias ....='builtin cd ../../..'
alias .4='builtin cd ../../../../'
alias .5='builtin cd ../../../../..'

# DirStack
alias dirsv='dirs -v' # List DirStack
for index in {1..9}; do alias "$index"="builtin cd +${index} > /dev/null"; done
unset index
alias d='fzf-change-dirstack'

# ls/eza aliases
alias l='eza'
alias ll='eza -lah --git --icons=always --colour-scale=size'
alias lll='eza -lah --git --icons=always --colour-scale=size --time-style=long-iso'
alias la='eza -ah'
alias lD='eza -lh --only-dirs'
alias lDD='eza -lah --only-dirs'
alias lF='eza -lh --only-files'
alias lFF='eza -lah --only-files'
alias lt='eza -Th --level=2'
alias ltt='eza -Tha --level=2'

# yazi
alias y="yazicdonquit"

# bat
alias cat="bat"
alias grep="batgrep --smart-case" # Colorful Grep with sane defaults

# WSL2/Windows
alias reveal="explorer.exe ." # Reveal current dir in File explorer
alias shutdown="wsl.exe --shutdown"
alias terminate="wsl.exe --terminate archlinux"

# configs
alias zshconf="nvim ~/minfiles/.homedir/.config/zsh/.zshrc"
alias zshenv="nvim ~/minfiles/.homedir/.zshenv"
alias updateconf="nvim ~/minfiles/scripts/update_all.zsh"
alias p10kconf="nvim ~/minfiles/.homedir/.config/zsh/.p10k.zsh"
alias aliasconf="nvim ~/minfiles/.homedir/.config/zsh/zsh-aliases.zsh" # <- this file
alias histedit="nvim ${XDG_DATA_HOME}/zsh_history"

# make
alias remake='make clean && make'

# count files
alias count='find . -type f | wc -l'

# list files/dir by size
alias dust='du -sh * | sort -hr'

# rsync aliases
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --delete-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-update="rsync -avzu --delete --progress -h"

# Git
alias gis="git status"
alias gss="git status -s"
alias gid="git diff"
alias gilg="git lg"
alias glog="git log"
alias gsub="git submodule update --remote --rebase"

# vim
alias vim=nvim
alias vi=nvim

# texlive
alias updatetl="tlmgr update --self --all --reinstall-forcibly-removed"

# File manipulation
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"

# Global aliases
alias -g NE="2>/dev/null" # Send [N]ull [E]rror to /dev/null
alias -g DN=">/dev/null" # Send standard output to /dev/null
alias -g NUL=">/dev/null 2>&1" # Send all output to /dev/null
alias -g C="| tee >(win32yank.exe -i)" # [Copy] output of command
alias -g L='| bat' # Pipe output to [L]ess pager with bat coloring

# misc
alias lg="lazygit"
alias bcd="builtin cd"
alias pse="zsh ~/minfiles/scripts/pse.zsh"
alias deleteCompDump="rm ${ZDOTDIR}/.zcompdump"

