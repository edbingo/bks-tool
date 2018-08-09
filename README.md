# README BKS-TOOL

This tool aims to provide a registration page to year 5 students, so that they
can sign up for Matura presentations presented by year 6 students. Built on
rails and passenger, it is designed to run on a debian server with apache.

Uses RUBY 2.5.1 and RAILS 5.2.0

# SETUP GUIDE
If possible use the install and setup scripts.
## Run these commands as root
### Update system
`apt update && apt upgrade`
### Install required packages
`apt install curl gnupg build-essential dirmngr`
### Add RVM key to the keychain
`gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
### Download RVM with curl
`curl -sSL https://get.rvm.io | bash -s stable`
### Set rvm source
`source /etc/profile.d/rvm.sh`
### Add users to rvm group
`usermod -a G `whoami``
### Install Ruby
`rvm install ruby-2.5.1`
### Set installed version as default
`rvm --default use ruby-2.5.1`
### Install the bundler gem
`gem install bundler --no-rdoc --no-ri`
### Install nodejs for Rails compatability
`apt update && apt install -y apt-transport-https ca-certificates && curl --fail -ssL -o setup-nodejs https://deb.nodesource.com/setup_8.x && bash setup-nodejs && sudo apt-get install -y nodejs build-essential`
