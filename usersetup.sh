#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'


source /etc/profile.d/rvm.sh
cd /var/www
echo -e $TEXT_RED_B'\e[1;31m'
echo "Changed to folder"
echo -e $TEXT_RESET
git clone https://bitbucket.org/elancaster/bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "Source cloned to folder"
echo -e $TEXT_RESET

# Install app dependencies
rvm rvmrc warning ignore /var/www/bks-tool/Gemfile
cd /bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "Changed to source folder"
echo -e $TEXT_RESET
bundle install --deployment --without development test
echo -e $TEXT_RED_B'\e[1;31m'
echo "Bundler installed"
echo -e $TEXT_RESET
exit
exit
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
