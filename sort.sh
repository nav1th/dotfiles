#!/bin/bash
cd conffiles 
if [ $? -eq 0 ]; then
    cp .profile .tmux.conf .zshrc ~
    cp .starship.toml ~/.config
    cp init.vim ~/.config/nvim
    cd ..
else
    echo "Not in the directory of the git repo, need to be inside of it for script to work"
