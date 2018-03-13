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
    exit
else
    echo "##### ERROR IN RUNNING cp -f .gitconfig ~/.gitconfig #####"
    exit
fi

##############
# VIM INSTALL#
##############

echo "##### Installing vim... #####"

sudo apt-get -y install vim

OUT=$?
if [ $OUT -eq 0 ];then
    echo "##### Done with installing vim. Updating configurationss #####"
    rm -rf ~/.vim rm -f ~/.vimrc
    mkdir ~/.vim
    cp .netrwhist ~/.vim/.netwrhist
    cp .vimrc ~/.vim/.vimrc
    cp * ~/.vim 
    cp ~/.vim/.vimrc ~/.vimrc
else
    echo "##### ERROR IN RUNNING sudo apt-get -y install vim #####"
    exit
fi
