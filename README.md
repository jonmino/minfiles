# Minfiles
My personal dotfiles based on the amazing work of other people.

## Prerequisites and Recommendations
### Required basic programs:
```
apt install build-essential cmake coreutils curl evince fzf less make ripgrep sshfs tar unzip wget
```
### ZSH
```
apt install zsh
```
#### ZSH Plugins
First install the Plugin manager:

Then install the following plugins:
### Git
```
apt install git
```
### GNU Stow
```
apt install stow
```
You should also already have a patched font installed and applied to your terminal.
wezterm.lua makes use of FiraCode Nerd Font from https://www.nerdfonts.com/
with [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) as Fallback.
and [SourceCodePro](https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf) as a further fallback.
## Apply configuration
First use git to clone the configuration to `~/minfiles`
```
git clone git@github.com:jonmino/minfiles.git ~
```
To apply the configuration for Zsh we need to symlink the .zshenv file first:
```
ln -s ~/minfiles/.zshenv ~/.zshenv
```
Everyhting can be symlinked to the correct place by running:
```
stow */
```
### Further commands that need to be run:
Apply the catppuccin theme to fast-syntax-highlighting
```
fast-theme XDG:catppuccin-mocha
```
