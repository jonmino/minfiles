#!/bin/zsh
echo "Running update Script"
yay -Syu
# Reinstall/Update Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
nvm install --lts
mamba self-update
mamba update all
mamba clean --all --yes
tlmgr update --self --all --reinstall-forcibly-removed
