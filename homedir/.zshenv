#!/usr/bin/env zsh
# Is always and first executed when using ZSH
# File to export Environment Variables
# Should not contain anything else

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}

# WezTerm -> https://wezfurlong.org/wezterm/config/lua/config/term.html
export TERMINFO=${XDG_CONFIG_HOME:-$HOME/.config}/wezterm/.terminfo
export TERM="wezterm"
export COLORTERM="truecolor"
export TERM_PROGRAM="WezTerm"

# ZSH
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}
export max_print_line=2147483647
export HISTFILE=$XDG_DATA_HOME/zsh_history
export CASE_SENSITIVE="true"
export HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=10000
export SAVEHIST=10000

# Default applications
export EDITOR=nvim
export BROWSER=firefox
export PAGER=less

# PATH
export PATH="$HOME/.local/bin:$PATH"

# LaTex / Texlive
export PATH="$HOME/.local/texlive/2023/bin/x86_64-linux:$PATH"
export MANPATH="$HOME/.local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$HOME/.local/texlive/2023/texmf-dist/doc/man:$INFOPATH"

# MISC
export VIMCONFIG=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
