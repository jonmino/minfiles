#!/usr/bin/env zsh
# Is executed evertime an Interactive Shell is launched
# Used to set up ways of interacting with ZSH

# Load ZSH Settings
source ${ZDOTDIR}/zsh-options.zsh

# Load Configs
source ${ZDOTDIR}/zsh-integrations.zsh
source ${ZDOTDIR}/zsh-completion.zsh
source ${ZDOTDIR}/zsh-functions.zsh
source ${ZDOTDIR}/zsh-aliases.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

zle_highlight+=('paste:none')

# Initialize OhMyPosh
eval "$(oh-my-posh init zsh --config ~/.config/omp/ompconfig.toml)"

# Initialize ssh-agent with suppressed output
{eval "$(ssh-agent -s)";} &>/dev/null

# Zoxide
eval "$(zoxide init zsh --cmd cd)" # Initialize zoxide and replace cd command with it

# Load dircolors
eval "$(dircolors -b $ZDOTDIR/dircolors)"

# Find autosuggestion match from Completion then history
export ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)

# Use emacs keybindings for command line
bindkey -e
# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^O' mambas # ctrl + o as shortcut keybinding
# Edit line in editor with <CTRL-E>:
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/jonmino/.local/conda/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/jonmino/.local/conda';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Node/NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Load other Plugins
source ~/minfiles/submodules/zsh-bd/bd.zsh
source ~/minfiles/submodules/zsh-no-ps2/zsh-no-ps2.plugin.zsh
source ~/minfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/minfiles/submodules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/minfiles/submodules/universalarchive.zsh
source ~/minfiles/submodules/universalextract.zsh
