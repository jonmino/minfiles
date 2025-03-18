#!/bin/zsh
# Script that installs programms these dotfiles depend on

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo "Installing applications from apt"
while read -r p ; do sudo pacman -Sy $p ; done < <(cat << "EOF"
    base
    base-devel
    linux-lts
    linux-firmware
    man
    sudo
    coreutils
    cmake
    curl
    evince
    file
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
    bat
    eza
    fd
    fzf
    lazygit
    neovim
    ripgrep
    yazi
    pkgfile
    openssh
EOF
)

# Zoxide see https://github.com/ajeetdsouza/zoxide for installation guide
echo "Installing Zoxide ..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo
echo
echo
echo "Install script is finised"
echo "Now restart the Shell and link the dotfiles using stow"
