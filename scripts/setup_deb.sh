#!/usr/bin/env bash

# Setup a newly installed Debiant Distro (Ubuntu, Pop!_OS...)

echo '------------------------------------------------------------------------'
echo '=> Debiant post-install script'
echo '------------------------------------------------------------------------'

# Variables
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )


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
# => Utilities
# -------------------------------------------------------

# Aptitude packages
sudo apt install -y --no-install-recommends \
build-essential \
snapd \
gnome-tweaks \
fish \
htop \
neofetch \
neovim

# -------------------------------------------------------
# => Development Packages
# -------------------------------------------------------

# NodeJS, Git, Docker, VS Code

# -------------------------------------------------------
# => Apps
# -------------------------------------------------------
echo '=> Install favorite applications'
echo '=> chromium-browser spotify steam telegram'
echo -e '=> Are you sure? [Y/n] '
read confirmation

confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then
  # Snaps
  sudo snap install spotify telegram-desktop

  # deb packages
  sudo apt install -y --no-install-recommends \
    chromium-browser \
    steam
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
# => Wrap up
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
