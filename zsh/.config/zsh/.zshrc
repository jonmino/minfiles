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
eval "$(zoxide init zsh --cmd cd)" # Initialize zoxide and replace cd command with it

source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-integrations

# Basic Settings
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-functions
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh-aliases
source /etc/zsh_command_not_found
zle_highlight+=('paste:none')
setopt COMBINING_CHARS # combine umlauts

# Completion
[ ! "$(find $ZDOTDIR/.zcompdump -mtime 1)" ] || compinit
compinit -C
zstyle ':completion:*' menu select # Menu selection of Tab complete
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files
fpath=(~/minfiles/submodules/zsh-completions/src $fpath)
export ZSH_AUTOSUGGEST_STRATEGY=(
    completion
    history
)

# vi mode
bindkey -v
export KEYTIMEOUT=1
precmd_functions+=(_fix_cursor) # Change default Cursor

# Use vim keys in tab complete menu: Broken?
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Keybindings
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^o' mambas # ctrl + q as shortcut keybinding

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jomino/.local/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

# Sourcing Theme
source ~/minfiles/submodules/powerlevel10k/powerlevel10k.zsh-theme

# Load other Plugins
source ~/minfiles/submodules/zsh-no-ps2/zsh-no-ps2.plugin.zsh
source ~/minfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/minfiles/submodules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
