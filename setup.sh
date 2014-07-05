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

echo -n "Install node stack? (nvm, jshint, rlwrap, heroku) [y] or n: "
read innode
while [ "$innode" != "y" -a "$innode" != "n" -a "$innode" != "" ]; do
    echo -n "Please enter [y] or n: "
    read innode
done
if [ "$innode" != "n" ]; then
    # Install nvm: node-version manager
    # https://github.com/creationix/nvm
    # Load nvm and install latest production node

    # DOESN'T WORK FOR SOME REASON
    # curl https://raw.github.com/creationix/nvm/master/install.sh | sh
    # HAVE TO USE WGET INSTEAD
    wget https://raw.github.com/creationix/nvm/master/install.sh
    sh install.sh

    source $HOME/.nvm/nvm.sh
    nvm install v0.10.12
    nvm use v0.10.12
    
    # Install jshint to allow checking of JS code within emacs
    # http://jshint.com/
    npm install -g jshint
    
    # Install rlwrap to provide libreadline features with node
    # See: http://nodejs.org/api/repl.html#repl_repl
    sudo apt-get install -y rlwrap

    # Install Heroku toolbelt
    # https://toolbelt.heroku.com/debian
    wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
