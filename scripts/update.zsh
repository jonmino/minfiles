#!/bin/zsh
echo "Running update Script"
sudo apt-get update
sudo apt-get full-upgrade
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get upgrade
sudo apt-get autoremove
brew update
brew outdated
brew upgrade
brew cleanup
mamba upgrade all
mamba clean --all --yes
tlmgr update --self --all --reinstall-forcibly-removed
