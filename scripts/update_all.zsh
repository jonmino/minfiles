#!/usr/bin/env zsh
set -uo pipefail
echo "Running update all Script"
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Ensure not run as root
if [ "$(id -u)" -eq 0 ] || [ -n "${SUDO_USER:-}" ]; then
    echo "${RED}Run as normal user, not via sudo.${NC}"
    exit 1
fi

echo "Running yay -Syu"
# yay should succeed before running any other upgrade
yay -Syu || exit 1

oh-my-posh upgrade

# Reinstall/Update Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Update Mamba
if mamba update mamba; then # explicitly update mamba first
    if mamba update all; then
        mamba clean --all --yes
    fi
fi

# Update TexLive
tlmgr update --self --all --reinstall-forcibly-removed

# Source and updated nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use --lts
nvm install --lts --reinstall-packages-from=current
nvm install-latest-npm
nvm use --lts
echo -e "\n${YELLOW}Listing all installed versions. Please uninstall older versions.${NC}"
nvm list
