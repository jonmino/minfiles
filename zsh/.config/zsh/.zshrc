# Initialize ssh-agent
eval $(ssh-agent -s)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic Settings
source ~/minfiles/submodules/powerlevel10k/powerlevel10k.zsh-theme
source ${XDG_CONFIG_HOME}/zsh/zsh-functions
source ${XDG_CONFIG_HOME}/zsh/zsh-aliases
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

# Keybindings
bindkey '^q' mambas # ctrl + q as shortcut keybinding

# Mocha Theme for fast syntax highlighting
source ~/.config/zsh/catppuccin_mocha-fzf.zsh

# plugins=(
#     command-not-found # suggestions on how to get command working
#     copybuffer # "CTRL-O" to Coppy current Textinput
#     copypath # "copypath" to clipboard
#     dirhistory # Navigate directories with alt+arrow keys
#     k # k for better ls
#     sudo #Doppel "ESC" für sudo
#     zsh-autosuggestions # auto completion
#     fast-syntax-highlighting # fast fish like syntax highlighting
#     # zsh-vi-mode # better vim mode
# )
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
setopt COMBINING_CHARS # combine umlauts
eval "$(zoxide init zsh --cmd cd)"

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
