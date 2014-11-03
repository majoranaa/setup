#!/bin/bash
# Simple setup.sh for configuring Ubuntu
# for headless setup. 

# git pull and install dotfiles as well
cd $HOME
if [ -e ./.bash_profile ]; then
    mv .bash_profile .bash_profile.old
fi
if [ -e ./.bashrc ]; then
    mv .bashrc .bashrc.old
fi
if [ -e ./.screenrc ]; then
    mv .screenrc .screenrc.old
fi
if [ -e ./.bashrc_custom ]; then
    mv .bashrc_custom .bashrc_custom.old
fi
if [ -e ./.bash_logout ]; then
    mv .bash_logout .bash_logout.old
fi
if [ -d ./.emacs.d/ ]; then
    rm -rf .emacs.d.old
    mv -f .emacs.d .emacs.d.old
fi
if [ -d ./doot/ ]; then
    rm -rf doot.old
    mv -f doot doot.old
fi
git clone git@github.com:majoranaa/doot.git
ln -sb doot/.screenrc .
ln -sb doot/.bash_profile .
ln -sb doot/.bashrc .
ln -sb doot/.bashrc_custom .
ln -sb doot/.bash_logout .
ln -sf doot/.emacs.d .

sudo apt-get install -y git
echo -n "Enter git name: "
read gitname
echo -n "Enter git email: "
read gitemail
git config --global user.name "$gitname"
git config --global user.email "$gitemail"
sudo apt-get install -y curl

echo -n "Install node stack? (nvm, jshint, rlwrap, heroku, express, bower) [y] or n: "
read innode
while [ "$innode" != "y" -a "$innode" != "n" -a "$innode" != "" ]; do
    echo -n "Please enter [y] or n: "
    read innode
done
if [ "$innode" != "n" ]; then
    # Install nvm: node-version manager
    # https://github.com/creationix/nvm
    # Load nvm and install latest production node

    curl https://raw.githubusercontent.com/creationix/nvm/v0.17.3/install.sh | bash

    source $HOME/.nvm/nvm.sh
    nvm install v0.10.33
    nvm use v0.10.33
    nvm install -g npm
    
    # Install jshint to allow checking of JS code within emacs
    # http://jshint.com/
    npm install -g jshint
    
    # Install rlwrap to provide libreadline features with node
    # See: http://nodejs.org/api/repl.html#repl_repl
    sudo apt-get install -y rlwrap

    # Install Heroku toolbelt
    # https://toolbelt.heroku.com/debian
    wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    
    # Install express & bower
    npm install -g express
    npm install -g bower
fi

# LAMP Stack. Refer to https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-14-04
# for more info on installing for Ubuntu 14.04
echo -n "Install LAMP stack? (Apache 2.4.7, Mysql 5.5.37, PHP 5.5.9, (i.e. the latest versions) [y] or n: "
read inlamp
while [ "$inlamp" != "y" -a "$inlamp" != "n" -a "$inlamp" != "" ]; do
    echo -n "Please enter [y] or n: "
    read inlamp
done
if [ "$inlamp" != "n" ]; then
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
    sudo mysql_install_db
    sudo mysql_secure_installation
    sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt
fi

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
