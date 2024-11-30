#!/bin/zsh
# Script that installs programms these dotfiles depend on

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo "Adding unstable Neovim channel"
sudo add-apt-repository ppa:neovim-ppa/unstable -y

echo "Updating package list..."
sudo apt-get update

echo "Installing basic tools"
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    build-essential
    coreutils
    cmake
    curl
    evince
    fd-find
    file
    fonts-powerline
    fzf
    git
    less
    make
    most
    ripgrep
    rsync
    stow
    sshfs
    tar
    unzip
    wget
    7zip
EOF
)

echo "Installing configured by the dotfiles..."
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    neovim
    zoxide
    eza
EOF
)

# Lazygit
echo "Installing Lazygit ..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz
rm -rf lazygit

echo "Installed Lazygit version is $(lazygit --version)" 

# Yazi
echo "Head to https://github.com/sxyazi/yazi/releases to find the latest release"
echo "Download latest release and move binaries to /usr/bin/"
echo "After that restart the Shell and link the dotfiles using stow"
