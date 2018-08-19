#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cd /

# Adds dedicated user for safety reasons
useradd -m -p SiYnqBkxiqWvo bkstool
source /etc/profile.d/rvm.sh
usermod -a -G rvm bkstool

# Makes folder to hold webapp
mkdir -p /var/www/bkstool
chown bkstool: /var/www/bkstool

# Switches to created folder and downloads repo
su - bkstool
source /etc/profile.d/rvm.sh
cd /var/www
git clone https://bitbucket.org/elancaster/bks-tool

# Install app dependencies
rvm rvmrc warning ignore /var/www/bks-tool/Gemfile
cd /bks-tool
bundle install --deployment --without development test
exit

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

apt -qq update
apt -qq upgrade
