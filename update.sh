#!/bin/bash

echo "##### Updating saved configurations files... #####"

echo -n "Overwriting ~/.vim/.vimrc with ~/.vimrc..."
cp -f ~/.vimrc ~/.vim/.vimrc
if [ "$?" -ne "0" ]; then
    echo "failed"
    return 1
fi
echo "Done."

echo -n "Saving ~/.vimrc..." 
cp -f ~/.vimrc .
if [ "$?" -ne "0" ]; then
    echo "failed"
    return 2
fi
echo "Done."

echo -n "Saving ~/.tmux.conf..." 
cp -f ~/.tmux.conf .
if [ "$?" -ne "0" ]; then
    echo "failed"
    return 3
fi
echo "Done."

echo -n "Saving ~/.gitconfig..." 
cp -f ~/.gitconfig .
if [ "$?" -ne "0" ]; then
    echo "failed"
    return 4
fi
echo "Done."

echo "##### DONE #####"

