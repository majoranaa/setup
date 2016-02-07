#!/bin/bash
# Simple setup.sh for configuring a Macintosh OSX
# for headless setup. 

# git pull and install dotfiles (doot) as well
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
if [ -e ./.tmux.conf ]; then
    mv .tmux.conf .tmux.conf.old
fi
if [ -d ./.emacs.d/ ]; then
    rm -rf .emacs.d.old
    mv .emacs.d .emacs.d.old
fi
if [ -d ./doot/ ]; then
    rm -rf doot.old
    mv -f doot doot.old
fi
git clone git@github.com:majoranaa/doot.git
ln -sb doot/.screenrc .
ln -sb doot/.bash_profile .
ln -sb doot/.bashrc .
ln -sb doot/.tmux.conf .
mv .emacs.d .emacs.d~
ln -s doot/.emacs.d .

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
    echo "Installing Xcode dev tools..."
    xcode-select --install
# Install Homebrew
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
