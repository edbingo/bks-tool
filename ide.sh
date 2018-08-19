#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Fully upgrades the system
apt -qq update
echo -e $TEXT_RED_B'\e[1;31m'
echo "Updated apt repositories"
echo -e $TEXT_RESET

apt -qq upgrade -y
echo -e $TEXT_RED_B'\e[1;31m'
echo "Updated software"
echo -e $TEXT_RESET

# Installs prerequired packages
echo -e $TEXT_RED_B'\e[1;31m'
echo "Installing curl, gnupg, build-essential and dirmngr"
echo -e $TEXT_RESET
apt -qq install -y curl gnupg build-essential dirmngr

# Fetches key from server
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
echo -e $TEXT_RED_B'\e[1;31m'
echo "Key fetched"
echo -e $TEXT_RESET

# Fetches RVM from server
curl -sSL https://get.rvm.io | bash -s stable
echo -e $TEXT_RED_B'\e[1;31m'
echo "RVM installed"
echo -e $TEXT_RESET

# Sets rvm source file
source /etc/profile.d/rvm.sh
echo -e $TEXT_RED_B'\e[1;31m'
echo "Source has been set"
echo -e $TEXT_RESET

# Adds current user to rvm group
usermod -a -G rvm `whoami`
echo -e $TEXT_RED_B'\e[1;31m'
echo "current user added to rvm group"
echo -e $TEXT_RESET

# Installs the required version of Ruby
rvm install ruby-2.5.1
echo -e $TEXT_RED_B'\e[1;31m'
echo "Ruby 2.5.1 Installed"
echo -e $TEXT_RESET
# Sets installed version as default
rvm --default use ruby-2.5.1
echo -e $TEXT_RED_B'\e[1;31m'
echo "Ruby 2.5.1 set as default"
echo -e $TEXT_RESET

# Installs the bundler gem without documentation
gem install bundler --no-rdoc --no-ri
echo -e $TEXT_RED_B'\e[1;31m'
echo "Bundler installed"
echo -e $TEXT_RESET

# Installs nodejs for Rails compatability
apt install -y nodejs && ln -sf /usr/bin/nodejs /usr/local/bin/node
echo -e $TEXT_RED_B'\e[1;31m'
echo "NodeJS Installed"
echo -e $TEXT_RESET

echo -e $TEXT_RED_B'\e[1;31m'
echo "Installation complete. DE now set up"
echo -e $TEXT_RESET
