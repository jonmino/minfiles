export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/texlive/2023/bin/x86_64-linux:$PATH"
export MANPATH="$HOME/.local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$HOME/.local/texlive/2023/texmf-dist/doc/man:$INFOPATH"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}
export HISTFILE=$XDG_DATA_HOME/zsh_history
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}
export ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)
