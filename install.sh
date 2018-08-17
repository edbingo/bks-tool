#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Fully upgrades the system
apt update
apt upgrade -y

# Installs prerequired packages
apt install curl gnupg build-essential dirmngr

# Fetches key from server
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# Fetches RVM from server
curl -sSL https://get.rvm.io | bash -s stable

# Sets rvm source file
source /etc/profile.d/rvm.sh

# Adds current user to rvm group
usermod -a -G rvm `whoami`

# Installs the required version of Ruby
rvm install ruby-2.5.1

# Sets installed version as default
rvm --default use ruby-2.5.1

# Installs the bundler gem without documentation
gem install bundler --no-rdoc --no-ri

# Installs nodejs for Rails compatability
apt update && apt install -y apt-transport-https ca-certificates && curl --fail -ssL -o setup-nodejs https://deb.nodesource.com/setup_8.x && bash setup-nodejs && sudo apt-get install -y nodejs build-essential

# Gets keys for passenger
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recvkeys 561F9B9CAC40B2F7

# Adds the repo to the sources list and refreshes them
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger stretch main > /etc/apt/sources.list.d/passenger.list'
apt update

# Installs the Passenger and Apache modules
apt install -y libapache2-mod-passenger

# Enable passenger mod (just in case)
a2enmod passenger
apache2ctl restart

echo -e $TEXT_RED_B='\e[1;31m'
echo "Installation complete. Please move on to step 2, setup.sh"
echo -e $TEXT_RESET
