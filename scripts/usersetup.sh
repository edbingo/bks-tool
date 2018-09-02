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
echo "Install complete."
echo -e $TEXT_RESET
exit
