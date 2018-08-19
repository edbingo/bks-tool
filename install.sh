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
echo -e $TEXT_RED_B='\e[1;31m'
echo "Updated apt repositories"
echo -e $TEXT_RESET

apt -qq upgrade -y
echo -e $TEXT_RED_B='\e[1;31m'
echo "Updated software"
echo -e $TEXT_RESET

# Installs prerequired packages
echo -e $TEXT_RED_B='\e[1;31m'
echo "Installing curl, gnupg, build-essential and dirmngr"
echo -e $TEXT_RESET
apt -qq install -y curl gnupg build-essential dirmngr

# Fetches key from server
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
echo -e $TEXT_RED_B='\e[1;31m'
echo "Key fetched"
echo -e $TEXT_RESET

# Fetches RVM from server
curl -sSL https://get.rvm.io | bash -s stable
echo -e $TEXT_RED_B='\e[1;31m'
echo "RVM installed"
echo -e $TEXT_RESET

# Sets rvm source file
source /etc/profile.d/rvm.sh
echo -e $TEXT_RED_B='\e[1;31m'
echo "Source has been set"
echo -e $TEXT_RESET

# Adds current user to rvm group
usermod -a -G rvm root
echo -e $TEXT_RED_B='\e[1;31m'
echo "Root user added to rvm group"
echo -e $TEXT_RESET

# Installs the required version of Ruby
rvm install ruby-2.5.1
echo -e $TEXT_RED_B='\e[1;31m'
echo "Ruby 2.5.1 Installed"
echo -e $TEXT_RESET
# Sets installed version as default
rvm --default use ruby-2.5.1
echo -e $TEXT_RED_B='\e[1;31m'
echo "Ruby 2.5.1 set as default"
echo -e $TEXT_RESET

# Installs the bundler gem without documentation
gem install bundler --no-rdoc --no-ri
echo -e $TEXT_RED_B='\e[1;31m'
echo "Bundler installed"
echo -e $TEXT_RESET

# Installs nodejs for Rails compatability
echo "Installing nodejs"
apt -qq update && apt -qq install -y apt-transport-https ca-certificates && curl --fail -ssL -o setup-nodejs https://deb.nodesource.com/setup_8.x && bash setup-nodejs && sudo apt-get install -y nodejs build-essential
echo -e $TEXT_RED_B='\e[1;31m'
echo "nodejs installed"
echo -e $TEXT_RESET
# Gets keys for passenger
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recvkeys 561F9B9CAC40B2F7
echo -e $TEXT_RED_B='\e[1;31m'
echo "Passenger keys received"
echo -e $TEXT_RESET
# Adds the repo to the sources list and refreshes them
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger stretch main > /etc/apt/sources.list.d/passenger.list'
echo -e $TEXT_RED_B='\e[1;31m'
echo "Repo added to apt list"
echo -e $TEXT_RESET
apt -qq update
echo -e $TEXT_RED_B='\e[1;31m'
echo "Apt repositories updated"
echo -e $TEXT_RESET

# Installs the Passenger and Apache modules
apt -qq install -y libapache2-mod-passenger
echo -e $TEXT_RED_B='\e[1;31m'
echo "Passenger + Apache moules installed"
echo -e $TEXT_RESET

# Enable passenger mod (just in case)
a2enmod passenger
apache2ctl restart

echo -e $TEXT_RED_B='\e[1;31m'
echo "Installation complete. Please move on to step 2, setup.sh"
echo -e $TEXT_RESET
