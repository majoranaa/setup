#!/bin/bash
# Simple setup.sh for configuring a Macintosh OSX
# for headless setup. 

# git pull and install dotfiles (doot) as well
cd $HOME

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

# Check for Xcode
if [ ! -d /Applications/Xcode.app ]; then
    echo "Please install XCode first"
    exit 1
fi

echo -n "Install Homebrew? [y] or n: "
read inbrew
while [ "$inbrew" != "y" -a "$inbrew" != "n" -a "$inbrew" != "" ]; do
    echo -n "Please enter [y] or n: "
    read inbrew
done
if [ "$inbrew" != "n" ]; then
# Install Xcode developer tools
    echo "Installing Xcode dev tools... If already installed, will just output an error line."
    xcode-select --install
# Install Homebrew
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
