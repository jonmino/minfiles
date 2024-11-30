#!/bin/zsh
# Script that installs programms these dotfiles depend on

set -eu -o pipefail # fail on error and report it, debug all lines

echo "Updating package list..."
sudo apt-get update

echo "Installing applications from apt"
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    build-essential
    coreutils
    cmake
    curl
    evince
    file
    fonts-powerline
    git
    less
    make
    most
    rsync
    stow
    sshfs
    tar
    unzip
    wget
    7zip
EOF
)

echo "Installing other applications with Homebrew" # Versions in apt are to old

brew install eza fd fzf jesseduffield/lazygit/lazygit neovim ripgrep yazi

# Zoxide see https://github.com/ajeetdsouza/zoxide for installation guide
echo "Installing Zoxide ..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo
echo 
echo 
echo "Install script is finised"
echo "Now restart the Shell and link the dotfiles using stow"
