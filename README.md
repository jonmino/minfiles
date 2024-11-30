# Minfiles
My personal dotfiles based on the amazing work of other people.
They are configured in a way to allow seemless working using Ubuntu in WSL2 on Windows.
Full credit for everything in `zsh/.config/zsh/lib` goes to [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

## Prerequisites and Recommendations
### Synced Clipboard
For the clipboard to be synced between neovim and Windows you have to installed win32yank. The easiest way is
```
winget install win32yank
```
### Font with Utf8 Symbols
You should also already have a patched font installed and applied to your terminal.
wezterm.lua makes use of Monaspice Nerd Font from https://www.nerdfonts.com/
with [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) as Fallback.
and [SourceCodePro](https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf) as a further fallback.
The Fonts are necessary as the symbols are used to design the terminal experience and as icons in certain applications.

## Setup configuration
First use git to clone the configuration files and scripts to `~/minfiles`
```
git clone git@github.com:jonmino/minfiles.git ~
```
Before you can use the config the packges to be configured need to be installed.

### Install ZSH
The next step is to install ZSH as most of the config is built ontop of it.
To do that just run the provided script with system user priveleges
```
sudo ./scripts/install_zsh.sh
```

### Install Dependencies
This repository contains configurations for a few tools and implements those using aliases and sometimes even overrites defaults. To not run into command not found erros, install the required packages using
```
sudo ./scripts/install_dependencies.zsh
```
To apply the configuration for Zsh we need to symlink the .zshenv file first:
```
ln -s ~/minfiles/.zshenv ~/.zshenv
```
This will export a few system variables and redefine some defaults.
After that everyhting can be symlinked to the correct place by running:
```
stow */
```
### Further commands that need to be run:
Apply the catppuccin theme to fast-syntax-highlighting
```
fast-theme XDG:catppuccin-mocha
```
