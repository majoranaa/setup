#!/bin/bash
# Simple setup.sh for configuring Linux
# for headless setup. 

# git pull and install dotfiles as well
cd $HOME

echo -n "Install git? [y] or n: "
read in_install_git
while [ "$in_install_git" != "y" -a "$in_install_git" != "n" -a "$in_install_git" != "" ]; do
    echo -n "Please enter [y] or n: "
    read in_install_git
done
if [ "$in_install_git" != "n" ]; then
    sudo apt-get install -y git
fi

echo -n "Configure git? [y] or n: "
read in_config_git
while [ "$in_config_git" != "y" -a "$in_config_git" != "n" -a "$in_config_git" != "" ]; do
    echo -n "Please enter [y] or n: "
    read in_config_git
done
if [ "$in_config_git" != "n" ]; then
    echo -n "Enter git name: "
    read gitname
    echo -n "Enter git email: "
    read gitemail
    git config --global user.name "$gitname"
    git config --global user.email "$gitemail"
fi

echo -n "Import dotfiles (doot)? [y] or n: "
read in_doot
while [ "$in_doot" != "y" -a "$in_doot" != "n" -a "$in_doot" != "" ]; do
    echo -n "Please enter [y] or n: "
    read in_doot
done
if [ "$in_doot" != "n" ]; then
    if [ -d ./doot/ ]; then
	rm -rf doot.old
	mv -f doot doot.old
    fi
    git clone git@github.com:majoranaa/doot.git

    echo -n "Link .bash_profile? [y] or n: "
    read in_bash_profile
    while [ "$in_bash_profile" != "y" -a "$in_bash_profile" != "n" -a "$in_bash_profile" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_bash_profile
    done
    if [ "$in_bash_profile" != "n" ]; then
	if [ -e ./.bash_profile ]; then
	    mv .bash_profile .bash_profile.old
	fi
	ln -s doot/.bash_profile .
    fi

    echo -n "Link .bashrc? [y] or n: "
    read in_bashrc
    while [ "$in_bashrc" != "y" -a "$in_bashrc" != "n" -a "$in_bashrc" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_bashrc
    done
    if [ "$in_bashrc" != "n" ]; then
	if [ -e ./.bashrc ]; then
	    mv .bashrc .bashrc.old
	fi
	ln -s doot/.bashrc .
    fi

    echo -n "Link .screenrc? [y] or n: "
    read in_screenrc
    while [ "$in_screenrc" != "y" -a "$in_screenrc" != "n" -a "$in_screenrc" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_screenrc
    done
    if [ "$in_screenrc" != "n" ]; then
	if [ -e ./.screenrc ]; then
	    mv .screenrc .screenrc.old
	fi
	ln -s doot/.screenrc .
    fi

    echo -n "Link .tmux.conf? [y] or n: "
    read in_tmuxconf
    while [ "$in_tmuxconf" != "y" -a "$in_tmuxconf" != "n" -a "$in_tmuxconf" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_tmuxconf
    done
    if [ "$in_tmuxconf" != "n" ]; then
	if [ -e ./.tmux.conf ]; then
	    mv .tmux.conf .tmux.conf.old
	fi
	ln -s doot/.tmux.conf .
    fi

    echo -n "Link .bash_logout? [y] or n: "
    read in_bash_logout
    while [ "$in_bash_logout" != "y" -a "$in_bash_logout" != "n" -a "$in_bash_logout" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_bash_logout
    done
    if [ "$in_bash_logout" != "n" ]; then
	if [ -e ./.bash_logout ]; then
	    mv .bash_logout .bash_logout.old
	fi
	ln -s doot/.bash_logout .
    fi

    echo -n "Link .emacs.d? [y] or n: "
    read in_emacsd
    while [ "$in_emacsd" != "y" -a "$in_emacsd" != "n" -a "$in_emacsd" != "" ]; do
	echo -n "Please enter [y] or n: "
	read in_emacsd
    done
    if [ "$in_emacsd" != "n" ]; then
	if [ -d ./.emacs.d/ ]; then
	    rm -rf .emacs.d.old
	    mv .emacs.d .emacs.d.old
	fi
	ln -s doot/.emacs.d .
    fi
fi

echo -n "Install curl? [y] or n: "
read incurl
while [ "$incurl" != "y" -a "$incurl" != "n" -a "$incurl" != "" ]; do
    echo -n "Please enter [y] or n: "
    read incurl
done
if [ "$incurl" != "n" ]; then
    sudo apt-get install -y curl
fi

echo -n "Install node stack? (nvm, jshint, rlwrap, heroku, express, bower) y or [n]: "
read innode
while [ "$innode" != "y" -a "$innode" != "n" -a "$innode" != "" ]; do
    echo -n "Please enter [y] or n: "
    read innode
done
if [ "$innode" == "y" ]; then
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
echo -n "Install LAMP stack? (Apache 2.4.7, Mysql 5.5.37, PHP 5.5.9, (i.e. the latest versions) y or [n]: "
read inlamp
while [ "$inlamp" != "y" -a "$inlamp" != "n" -a "$inlamp" != "" ]; do
    echo -n "Please enter [y] or n: "
    read inlamp
done
if [ "$inlamp" == "y" ]; then
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
    sudo mysql_install_db
    sudo mysql_secure_installation
    sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt
fi

# emacs
echo -n "Install emacs? [y] or n: "
read inemacs
while [ "$inemacs" != "y" -a "$inemacs" != "n" -a "$inemacs" != "" ]; do
    echo -n "Please enter [y] or n: "
    read inemacs
done
if [ "$inemacs" != "n" ]; then
    sudo apt-get install -y emacs
fi
