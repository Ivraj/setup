#!/bin/bash

#################
# UPDATE SYSTEM #
#################

echo "##### Updating System... #####"

sudo apt-get -y update

if [ "$?" -ne 0 ];then
    echo "##### ERROR IN RUNNING sudo apt-get -y update #####"
    exit
fi

echo "##### Done with system update #####"

####################
# APT-FAST INSTALL #
####################

sudo add-apt-repository ppa:saiarcot895/myppa
sudo apt-get update
sudo apt-get -y install apt-fast

if [ "$?"-ne "0" ];then
    echo "##### ERROR IN RUNNING sudo apt-get -y install apt-fast #####"
    exit
fi

echo "##### Done with installing apt-fast #####"


########################
# .BASH_ALIASES UPDATE #
########################

echo "##### Overwriting .bash_aliases to ~/ #####"

cp -f .bash_aliases ~/.bash_aliases

if [ "$?"-ne "0" ];then
    echo "##### ERROR IN RUNNING cp -f .bash_aliases ~/.bash_aliases #####"
    exit
fi

echo "##### Done with updating .bash_aliases #####"

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
# NPM INSTALL #
###############

echo "##### Installing npm... #####"

sudo apt-get -y install npm

if [ "$?"-ne "0" ];then
    echo "##### ERROR IN RUNNING sudo apt-get -y install npm #####"
    exit
fi

echo "##### Done with installing npm #####"

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

##############
# i3 INSTALL #
##############

#echo -n "Installing i3..."

#sudo apt-get -y install i3

#if [ "$?" -ne "0" ]; then
    #echo "failed."
    #return 1
#fi

#echo "Done."

#echo "NEED TO EDIT SCRIPT SO IT UPDATES i3 CONF"

##################
# VSCODE INSTALL #
##################

#echo -n "Installing VSCode..."

#sudo apt-get -y install code

#if [ "$?" -ne "0" ]; then
    #echo "failed."
    #return 1
#fi

#echo "Done."

#echo "NEED TO EDIT SCRIPT SO IT UPDATES VSCODE CONF"

