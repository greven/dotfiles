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
JUNO_TEXT='#94A3A5'
JUNO_BG='#0A0B11'
PALETTE_JUNO='#282A36:#F37F97:#5ADECD:#F2A272:#8897F4:#C574DD:#79E6F3:#FDFDFD:#414458:#FF4971:#18E3C8:#FF8037:#556FFF:#B043D1:#3FDCEE:#BEBEC1'

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ default-size-columns 132
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ default-size-rows 36
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ font 'Iosevka 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ foreground-color $JUNO_TEXT
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ background-color $JUNO_BG
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ background-transparency-percent 1
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${GNOME_TERMINAL_PROFILE:1:-1}/ palette $PALETTE_JUNO


# Set fish as default shell
chsh -s `which fish`

echo 'Done.'
