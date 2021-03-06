#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'


source /etc/profile.d/rvm.sh
rvm rvmrc warning ignore /var/www/bks-tool/Gemfile
cd /var/www/bks-tool
echo -e $TEXT_RED_B'\e[1;31m'
echo "Changed to folder"
echo -e $TEXT_RESET
echo -e $TEXT_RED_B'\e[1;31m'
echo "Source cloned to folder"
echo -e $TEXT_RESET

# Install app dependencies
echo -e $TEXT_RED_B'\e[1;31m'
echo "Changed to source folder"
echo -e $TEXT_RESET
bundle install --deployment --without development test
echo -e $TEXT_RED_B'\e[1;31m'
echo "Bundler installed"
echo -e $TEXT_RESET

rails db:migrate RAILS_ENV=production
rails db:seed RAILS_ENV=production

echo "Install complete. Please restart, then check athene.bks-campus.ch"
