#!/usr/bin/env zsh
# Is executed evertime an Interactive Shell is launched
# Used to set up ways of interacting with ZSH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Initialize ssh-agent with suppressed output
{eval "$(ssh-agent -s)";} &>/dev/null

# Zoxide
eval "$(zoxide init zsh --cmd cd)" # Initialize zoxide and replace cd command with it

# Sourcing Theme
source ~/minfiles/submodules/powerlevel10k/powerlevel10k.zsh-theme

# Load dircolors
eval "$(dircolors -b $ZDOTDIR/dircolors)"

# Load ZSH Settings
source ${ZDOTDIR}/zsh-options

# Load Configs
source ${ZDOTDIR}/zsh-integrations
source ${ZDOTDIR}/zsh-completion
source ${ZDOTDIR}/zsh-functions
source ${ZDOTDIR}/zsh-aliases
source ${ZDOTDIR}/zsh-vi-mode
source /usr/share/doc/pkgfile/command-not-found.zsh
zle_highlight+=('paste:none')

# Find autosuggestion match from Completion then history
export ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^O' mambas # ctrl + o as shortcut keybinding

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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
