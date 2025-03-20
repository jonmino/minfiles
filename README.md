# Minfiles
My personal dotfiles based on the amazing work of other people.
They are configured in a way to allow seemless working using Archlinux in WSL2 on Windows.
Full credit for everything in `zsh/.config/zsh/lib` goes to [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

## Prerequisites and Recommendations
### Font with Utf8 Symbols
You should also already have a patched font installed and applied to your terminal.
wezterm.lua makes use of Monaspice Neon Font from the
[Monaspace Family](https://github.com/githubnext/monaspace).
The Fonts are necessary as the symbols are used to design the terminal experience
and as icons in certain applications.

### WSL2 with synced clipboard
To Install programs on the Windows side winget is used. There is two scripts for
it: [`enable_winget_hash_overrides.bat`](./scripts/enable_winget_hash_overrides.bat)
has to be run as Admin to enable overriding hash mismatches which is necessary
for one package. After that is enabled
[`install_winget_packages.bat`](./scripts/install_winget_packages.bat)
can be run to install the packages. Just for WSL to work properly only
the packages `WSL` and `win32yank` are necessary. The rest ist just other
programs I use.

### Install Archlinux for WSL
To install Archlinux follow [this](https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL)
from the official Arch Wiki. Make sure to set up a User with a working
environment. The file [`wsl.conf`](./other/wsl/wsl.conf) needs to be copied to
`/etc/` to set the default user. Make sure to set it to the name you configured
before.

### WSL Config Files
Due to WSL2 being a bit difficult with networking some settings have to be adjusted for VPN support.
The file [`resolved.conf`](./other/wsl/resolved.conf) needs to be copied to `/etc/systemd/`. This will override
the same file there. It configures DNS settings of the distribution.
Copy [`.wslconfig`](./other/wsl/.wslconfig) to `%UserProfile%` in Windows to enable the mirrored Networking
mode for all WSL2 distributions. Also run the following command
with admin priviliges in PowerShell to allow inbound connections:
```
New-NetFirewallHyperVRule -Name "MyWebServer" -DisplayName "My Web Server" -Direction Inbound -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -Protocol TCP -LocalPorts 80
```
You can read more about the why here: https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking

### Git
To be able to optain this repository with all it's files it is recommended
to use Git. This can be installed using
```
pacman -Sy git
```

## Setup configuration
First use Git to clone the configuration files and scripts to `~/minfiles`
```
git clone git@github.com:jonmino/minfiles.git ~/minfiles/ --recursive
```
Before you can use the config the packges to be configured need to be installed.

### Install ZSH
The next step is to install ZSH as most of the config is built ontop of it.
To do that just run the provided script with system user priveleges
```
sudo ./scripts/install_zsh.sh
```
Make sure that Zsh is now the default before continuing. You can check by
running
```
echo $SHELL
```

### Install Dependencies
This repository contains configurations for a few tools and implements those using aliases and sometimes even overrites defaults. To not run into command not found erros, install the required packages using
```
sudo ./scripts/install_dependencies.zsh
```
To apply the configuration everyhting can be symlinked to the correct place by running:
```
stow .homedir --no-folding --verbose
```
### Further commands that need to be run:
Apply the catppuccin theme to fast-syntax-highlighting
```
fast-theme XDG:catppuccin-mocha
```
Also rebuild bat's cache to enable the theme:
```
bat cache --build
```
