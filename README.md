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
wezterm.lua makes use of Monaspice Neon Font from the
[Monaspace Family](https://github.com/githubnext/monaspace).
The Fonts are necessary as the symbols are used to design the terminal experience
and as icons in certain applications.

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
The install script uses Homebrew to get up to date versions of certain tools, so that needs to be installed first.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
This repository contains configurations for a few tools and implements those using aliases and sometimes even overrites defaults. To not run into command not found erros, install the required packages using
```
sudo ./scripts/install_dependencies.zsh
```
To apply the configuration everyhting can be symlinked to the correct place by running:
```
stow .homedir
```
### Further commands that need to be run:
Apply the catppuccin theme to fast-syntax-highlighting
```
fast-theme XDG:catppuccin-mocha
```

### Enable VPN Connections
Due to WSL2 being a bit difficult with networking some settings have to be adjusted for VPN support.
The file [`resolved.conf`](./other/resolved.conf) needs to be copied to `/etc/systemd/`. This will override
the same file there. It configures DNS settings of the distribution.
Copy [`.wslconfig`](./other/.wslconfig) to `%UserProfile%` in Windows to enable the mirrored Networking
mode for all WSL2 distributions. Also run the following command
with admin priviliges in PowerShell to allow inbound connections:
```
New-NetFirewallHyperVRule -Name "MyWebServer" -DisplayName "My Web Server" -Direction Inbound -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -Protocol TCP -LocalPorts 80
```
You can read more about the why here: https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking
