#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cd /

# Adds dedicated user for safety reasons
useradd -m -p SiYnqBkxiqWvo bkstool LOGIN
echo -e $TEXT_RED_B='\e[1;31m'
echo "User has been added"
echo -e $TEXT_RESET
source /etc/profile.d/rvm.sh
echo -e $TEXT_RED_B='\e[1;31m'
echo "Source set"
echo -e $TEXT_RESET
usermod -a -G rvm bkstool
echo -e $TEXT_RED_B='\e[1;31m'
echo "User added to group rvm"
echo -e $TEXT_RESET

# Makes folder to hold webapp
mkdir -p /var/www/bkstool
echo -e $TEXT_RED_B='\e[1;31m'
echo "Folder created"
echo -e $TEXT_RESET
chown bkstool: /var/www/bkstool
echo -e $TEXT_RED_B='\e[1;31m'
echo "Permission given to new user"
echo -e $TEXT_RESET

# Switches to created folder and downloads repo
su - bkstool
echo -e $TEXT_RED_B='\e[1;31m'
echo "Switched to new user"
echo -e $TEXT_RESET
source /etc/profile.d/rvm.sh
cd /var/www
echo -e $TEXT_RED_B='\e[1;31m'
echo "changed to folder"
echo -e $TEXT_RESET
git clone https://bitbucket.org/elancaster/bks-tool
echo -e $TEXT_RED_B='\e[1;31m'
echo "Source cloned to folder"
echo -e $TEXT_RESET

# Install app dependencies
rvm rvmrc warning ignore /var/www/bks-tool/Gemfile
cd /bks-tool
echo -e $TEXT_RED_B='\e[1;31m'
echo "Changed to source folder"
echo -e $TEXT_RESET
bundle install --deployment --without development test
echo -e $TEXT_RED_B='\e[1;31m'
echo "Bundler installed"
echo -e $TEXT_RESET
exit
exit
echo -e $TEXT_RED_B='\e[1;31m'
echo "Switched back to root user"
echo -e $TEXT_RESET

# Configures the apache
touch /etc/apache2/sites-enabled/bkstool.conf
cd /etc/apache2/sites-enabled/
echo "<VirtualHost *:80>" >> bkstool.conf
echo "    ServerName athene.bks-campus.ch" >> bkstool.conf
echo "" >> bkstool.conf
echo "    # Tell Apache and Passenger where your app's 'public' directory is" >> bkstool.conf
echo "    DocumentRoot /var/www/bks-tool/public" >> bkstool.conf
echo "" >> bkstool.conf
echo "    PassengerRuby /usr/local/rvm/gems/ruby-2.5.1/wrappers/ruby" >> bkstool.conf
echo "" >> bkstool.conf
echo "    # Relaxes Apache security" >> bkstool.conf
echo "    <Directory /var/www/bks-tool/public>" >> bkstool.conf
echo "      Allow from all" >> bkstool.conf
echo "      Options -MultiViews" >> bkstool.conf
echo "    </Directory>" >> bkstool.conf
echo "</VirtualHost>" >> bkstool.conf
apache2ctl restart
echo -e $TEXT_RED_B='\e[1;31m'
echo "Apache configured and restarted"
echo -e $TEXT_RESET

apt -qq update
apt -qq upgrade
echo -e $TEXT_RED_B='\e[1;31m'
echo "Sys update finished"
echo -e $TEXT_RESET

echo -e $TEXT_RED_B='\e[1;31m'
echo "Installation complete! To test, go to athene.bks-campus.ch"
echo -e $TEXT_RESET
