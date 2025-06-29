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
    man
    sudo
    coreutils
    cmake
    curl
    evince
    file
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
    bat
    bat-extras
    eza
    fd
    fzf
    lazygit
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

echo
echo
echo
echo "Install script is finised"
echo "Now restart the Shell and link the dotfiles using stow"
