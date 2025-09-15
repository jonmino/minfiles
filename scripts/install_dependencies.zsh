#!/bin/zsh
# Script that installs programms these dotfiles depend on

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || {
    echo -e "\e[31mYou need sudo privilege to run this script\e[30m"
    exit 1
}

packages=(
    base
    base-devel
    linux-lts
    linux-firmware
    libxcrypt-compat
    git-lfs
    git-delta
    man
    sudo
    coreutils
    cmake
    curl
    evince
    file
    less
    make
    rsync
    stow
    sshfs
    tar
    unzip
    wget
    7zip
    bat
    bat-extras
    eza
    fd
    fzf
    lazygit
    tree-sitter
    neovim
    ripgrep
    yazi
    pkgfile
    openssh
)

echo "Installing applications from apt"
sudo pacman -Sy "${packages[@]}"

# Zoxide see https://github.com/ajeetdsouza/zoxide for installation guide
echo "Installing Zoxide ..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Node see https://nodejs.org/en/download for installation guide
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install --lts

# Verify the Node.js version:
node -v # Should print "v22.19.0".

# Verify npm version:
npm -v # Should print "10.9.3".

echo
echo
echo
echo "Install script is finised"
echo "Now restart the Shell and link the dotfiles using stow"
