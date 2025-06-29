#!/bin/bash
# Script to install Zsh, my favorite shell

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || {
    echo -e "\e[31mYou need sudo privilege to run this script\e[30m"
    exit 1
}

echo "Installing Zsh ..."
sudo pacman -Sy zsh
echo "Installed Zsh version is $(zsh --version)"

read -rp "?Is it a newer version than 5.0.8? (y/n) " yn
case $yn in
[Yy]*)
    echo ok continuing...
    echo Making Zsh the default shell
    chsh -s /usr/bin/zsh
    echo All done, now restart to use zsh
    echo "Confirm via echo \$SHELL and \$SHELL --version"
    ;;
[Nn]*)
    echo Figure out how to get a newer version!
    ;;
esac
