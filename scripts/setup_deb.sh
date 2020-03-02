#!/usr/bin/env bash

# Setup a newly installed Debiant Distro (Ubuntu, Pop!_OS...)
#
#
# Usage:
#   $ cd /tmp
#   $ wget https://gist.githubusercontent.com/raw/61a108013a6cc742575ec72dba2e635f/setup_deb.sh
#   $ chmod +x setup_deb.sh .sh
#   $ ./setup_deb.sh .sh
#

echo '------------------------------------------------------------------------'
echo '=> Debiant post-install script'
echo '------------------------------------------------------------------------'

# Variables
NVM_VERSION=0.35.2

# -----------------------------------------------------------------------------
# => Add PPAs (Personal Package Archives)
# -----------------------------------------------------------------------------
sudo apt-add-repository ppa:fish-shell/release-3 # Fish Shell
sudo apt-add-repository ppa:papirus/papirus # Papirus Icons

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
  code \
  docker \
  docker-compose
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
  # Install deb packages
  sudo apt install -y --no-install-recommends \
    chromium-browser \
    steam

  # Install Snaps
  sudo snap install spotify telegram-desktop
fi

# -------------------------------------------------------
# => Fonts
# -------------------------------------------------------

# - Iosevka, Victor Mono

# -------------------------------------------------------
# => Customization
# -------------------------------------------------------

# Icons
sudo apt install -y papirus-icon-theme

# Themes

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

  # Copy all dotfiles in the files directory to home
  cd "$dotfiles_path"/files
  cp -r `ls -d .??*` $HOME
fi

# Gnome Terminal Settings
GNOME_TERMINAL_PROFILE="$(gsettings get org.gnome.Terminal.ProfilesList default)"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'Iosevka 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-columns 132
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-size-rows 36
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ foreground-color 'rgb(148,163,165)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-color 'rgb(10,11,17)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ background-transparency-percent 1
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ palette ['rgb(40,42,54)', 'rgb(243,127,151)', 'rgb(90,222,205)', 'rgb(242,162,114)', 'rgb(136,151,244)', 'rgb(197,116,221)', 'rgb(121,230,243)', 'rgb(253,253,253)', 'rgb(65,68,88)', 'rgb(255,73,113)', 'rgb(24,227,200)', 'rgb(255,128,55)', 'rgb(85,111,255)', 'rgb(176,67,209)', 'rgb(63,220,238)', 'rgb(190,190,193)']


# Set fish as default shell
chsh -s `which fish`

echo 'Done.'
