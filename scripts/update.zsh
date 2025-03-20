#!/bin/zsh
echo "Running update Script"
sudo pacman -Syu
mamba self-update
mamba update all
mamba clean --all --yes
tlmgr update --self --all --reinstall-forcibly-removed
