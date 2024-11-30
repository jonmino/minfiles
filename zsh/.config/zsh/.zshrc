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

# Homebrew -> Needs to be this far up so installed applications are available
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Load ZSH Settings
source ${ZDOTDIR}/zsh-options

# Load Configs
source ${ZDOTDIR}/zsh-integrations
source ${ZDOTDIR}/zsh-functions
source ${ZDOTDIR}/zsh-aliases
source ${ZDOTDIR}/zsh-completion
source ${ZDOTDIR}/zsh-vi-mode
source /etc/zsh_command_not_found
zle_highlight+=('paste:none')

# Find autosuggestion match from Completion then history
export ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)

# Keybindings
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^o' mambas # ctrl + q as shortcut keybinding

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jomino/.local/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jomino/.local/conda/etc/profile.d/conda.sh" ]; then
        . "/home/jomino/.local/conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/jomino/.local/conda/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/jomino/.local/conda/etc/profile.d/mamba.sh" ]; then
    . "/home/jomino/.local/conda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Load other Plugins
source ~/minfiles/submodules/zsh-bd/bd.zsh
source ~/minfiles/submodules/zsh-no-ps2/zsh-no-ps2.plugin.zsh
source ~/minfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/minfiles/submodules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/minfiles/submodules/universalarchive.zsh
source ~/minfiles/submodules/universalextract.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
