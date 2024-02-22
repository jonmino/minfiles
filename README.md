# Minfiles
My personal dotfiles based on the amazing work of other people.

## Prerequisites and Recommendations
### Git
To install git on Ubuntu:
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
Everyhting can be symlinked to the correct place by running:
```
stow */
```
