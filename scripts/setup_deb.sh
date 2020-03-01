#!/usr/bin/env bash

# Setup a newly installed Debiant Distro (Ubuntu, Pop!_OS...)

echo '------------------------------------------------------------------------'
echo '=> Debiant post-install script'
echo '------------------------------------------------------------------------'

# Variables
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

sudo apt update

# -------------------------------------------------------
# => Utilities
# -------------------------------------------------------

# PPAs
sudo apt-add-repository ppa:fish-shell/release-3

sudo apt update

# Aptitude packages
sudo apt install -y \
gnome-tweaks \
fish \
htop \
neofetch \
neovim

# -------------------------------------------------------
# => Development
# -------------------------------------------------------

# NodeJS, Git, Docker, VS Code

# -------------------------------------------------------
# => Apps
# -------------------------------------------------------

# - Spotify, Telegram

# -------------------------------------------------------
# => Fonts
# -------------------------------------------------------

# - Iosevka, Victor Mono

# -------------------------------------------------------
# => Customization
# -------------------------------------------------------

# - Icons, Themes, etc.

# -------------------------------------------------------
# => Wrap up
# -------------------------------------------------------

# Config files
cd "$parent_path"
cp ../files/.gitconfig ~
cp -r ../files/.config/fish ~/.config/fish

sudo apt update && sudo apt upgrade -y

# Cleanup
