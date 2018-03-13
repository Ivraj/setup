#!/bin/bash

#################
# UPDATE SYSTEM #
#################

echo "##### Updating System... #####"

sudo apt-get -y update

OUT=$?
if [ $OUT -eq 0 ];then
    echo "##### Done with system update #####"
else
    echo "##### ERROR IN RUNNING sudo apt-get -y update #####"
    exit
fi

#######################
# UPDATING GIT CONFIG #
#######################

echo "##### Updating .gitconfig... #####"

cp -f .gitconfig ~/.gitconfig
OUT=$?
if [ $OUT -eq 0 ];then
    echo "##### Done with updating .gitconfig #####"
else
    echo "##### ERROR IN RUNNING cp -f .gitconfig ~/.gitconfig #####"
    exit
fi

###############
# VIM INSTALL #
###############

echo "##### Installing vim... #####"

sudo apt-get -y install vim

OUT=$?
if [ $OUT -eq 0 ];then
    echo "##### Done with installing vim. Updating configurations #####"

    rm -rf ~/.vim rm -f ~/.vimrc
    mkdir ~/.vim
    cp .netrwhist ~/.vim/.netwrhist
    cp .vimrc ~/.vim/.vimrc
    cp * ~/.vim 
    cp ~/.vim/.vimrc ~/.vimrc
    export EDITOR=vim

    echo "##### Done with updating vim configurations #####"

    echo "##### Installing Vundle... #####"

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    OUT=$?
    if [ $OUT -eq 0 ];then
        vim +PluginInstall +qall
    else
        echo "ERROR IN GIT CLONING VUNDLE REPO" 
        exit
    fi
else
    echo "##### ERROR IN RUNNING sudo apt-get -y install vim #####"
    exit
fi

################
# TMUX INSTALL #
################

echo "##### Installing tmux... #####"

sudo apt-get -y install tmux

OUT=$?
if [ $OUT -eq 0 ];then
    echo "##### Done with installing tmux. Updating configurations #####"
    rm -f ~/.tmux.conf
    cp .tmux.conf ~/.tmux.conf
    OUT=$?
    if [ $OUT -eq 0 ]; then
        echo "##### Done with updating tmux configurations #####"
    else
        echo "##### ERROR IN UPDATING TMUX CONFIGURATIONS #####"
        exit
    fi
else
    echo "##### ERROR IN RUNNING sudo apt-get -y install tmux #####"
    exit
fi

echo "##### DONE #####"
