#!/usr/bin/env bash

# Setup a newly installed Debiant Distro (Ubuntu, Pop!_OS...)
#
# Based on rougeth[0] script.
#
#
# [0] - https://gist.github.com/rougeth/8108714
#
# Usage:
#   $ cd /tmp
#   $ wget https://gist.githubusercontent.com/raw/61a108013a6cc742575ec72dba2e635f/setup_deb.sh
#   $ chmod +x setup_deb.sh .sh
#   $ ./setup_deb.sh .sh

echo '------------------------------------------------------------------------'
echo '=> Debiant post-install script'
echo '------------------------------------------------------------------------'

# Variables
NVM_VERSION=0.35.2

# -----------------------------------------------------------------------------
# => Add PPAs (Personal Package Archives)
# -----------------------------------------------------------------------------
sudo apt-add-repository ppa:fish-shell/release-3   # Fish Shell

# -------------------------------------------------------
# => System Update
# -------------------------------------------------------
sudo apt update -qq
sudo apt-get dist-upgrade -y

# -------------------------------------------------------
# => Deps & Utilities
# -------------------------------------------------------

# Aptitude packages
sudo apt install -y --no-install-recommends \
  build-essential \
  software-properties-common \
  apt-transport-https \
  snapd \
  curl \
  wget \
  fish \
  htop \
  neofetch \
  gnome-tweaks \
  neovim

# -------------------------------------------------------
# => Development Packages
# -------------------------------------------------------
echo '=> Install favorite applications'
echo '=> git docker NodeJS VSCode'
echo -e '=> Are you sure? [Y/n] '
read confirmation

confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then

# nvm (NodeJS)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash
nvm install --lts --latest-npm

# VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt install -y \
  git \
  code
fi

# -------------------------------------------------------
# => Apps
# -------------------------------------------------------
echo '=> Install favorite applications'
echo '=> chromium-browser spotify steam telegram'
echo -e '=> Are you sure? [Y/n] '
read confirmation

confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then
  # deb packages
  sudo apt install -y --no-install-recommends \
    chromium-browser \
    steam

  # Snaps
  sudo snap install spotify telegram-desktop
fi

# -------------------------------------------------------
# => Fonts
# -------------------------------------------------------

# - Iosevka, Victor Mono

# -------------------------------------------------------
# => Customization
# -------------------------------------------------------

# Gnome Terminal
# profile_path="/apps/gnome-terminal/profiles/Default"

# -------------------------------------------------------
# => Configurations
# -------------------------------------------------------

# Dot files
echo '=> Get dotfiles (https://github.com/greven/dotfiles)'
echo -e '=> Are you sure? [Y/n] '
read confirmation

confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then
  # Create a tmp folder
  dotfiles_path="`(mktemp -d)`"

  # Clone the repository
  git clone git@github.com:greven/dotfiles.git "$dotfiles_path"

  # Copy all dotfiles
  cd "$dotfiles_path"/files
  cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME
fi

# Set fish as default shell
chsh -s `which fish`

echo 'Done.'
