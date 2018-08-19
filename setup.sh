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
adduser bks-tool --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "bks-tool:Site.Access" | chpasswd
echo -e $TEXT_RED_B'\e[1;31m'
echo "User has been added"
echo -e $TEXT_RESET
source /etc/profile.d/rvm.sh
echo -e $TEXT_RED_B'\e[1;31m'
echo "Source set"
echo -e $TEXT_RESET
usermod -a -G rvm bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "User added to group rvm"
echo -e $TEXT_RESET

# Makes folder to hold webapp
mkdir -p /var/www/bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "Folder created"
echo -e $TEXT_RESET
chown bks-tool: /var/www/bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "Permission given to new user"
echo -e $TEXT_RESET

# Switches to created folder and downloads repo
echo -e $TEXT_RED_B'\e[1;31m'
echo "Switched to new user"
echo -e $TEXT_RESET
su - bks-tool | ./usersetup.sh

echo -e $TEXT_RED_B'\e[1;31m'
echo "Switched back to root user"
echo -e $TEXT_RESET

# Configures the apache
touch /etc/apache2/sites-enabled/bks-tool.conf
cd /etc/apache2/sites-enabled/
echo "<VirtualHost *:80>" >> bks-tool.conf
echo "    ServerName athene.bks-campus.ch" >> bks-tool.conf
echo "" >> bks-tool.conf
echo "    # Tell Apache and Passenger where your app's 'public' directory is" >> bks-tool.conf
echo "    DocumentRoot /var/www/bks-tool/public" >> bks-tool.conf
echo "" >> bks-tool.conf
echo "    PassengerRuby /usr/local/rvm/gems/ruby-2.5.1/wrappers/ruby" >> bks-tool.conf
echo "" >> bks-tool.conf
echo "    # Relaxes Apache security" >> bks-tool.conf
echo "    <Directory /var/www/bks-tool/public>" >> bks-tool.conf
echo "      Allow from all" >> bks-tool.conf
echo "      Options -MultiViews" >> bks-tool.conf
echo "    </Directory>" >> bks-tool.conf
echo "</VirtualHost>" >> bks-tool.conf
apache2ctl restart
echo -e $TEXT_RED_B'\e[1;31m'
echo "Apache configured and restarted"
echo -e $TEXT_RESET

apt -qq update
apt -qq upgrade
echo -e $TEXT_RED_B'\e[1;31m'
echo "Sys update finished"
echo -e $TEXT_RESET

echo -e $TEXT_RED_B'\e[1;31m'
echo "Installation complete! To test, go to athene.bks-campus.ch"
echo -e $TEXT_RESET
