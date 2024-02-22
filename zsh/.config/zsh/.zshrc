# Initialize ssh-agent
eval $(ssh-agent -s)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(zoxide init zsh --cmd cd)"

# Sourcing Plugins
source ~/minfiles/submodules/powerlevel10k/powerlevel10k.zsh-theme
source ~/minfiles/submodules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/minfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh

# Basic Settings
source ${XDG_CONFIG_HOME}/zsh/zsh-functions
source ${XDG_CONFIG_HOME}/zsh/zsh-aliases
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"
setopt COMBINING_CHARS # combine umlauts

# Keybindings
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^q' mambas # ctrl + q as shortcut keybinding

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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
