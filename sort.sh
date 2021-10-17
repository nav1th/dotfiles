#!/bin/bash
cd conffiles 
if [ $? -eq 0 ]; then
    cp .profile .tmux.conf .zshrc ~
    cp .starship.toml ~/.config/starship.toml
    mkdir ~/.config/nvim 2> /dev/null
    #sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    cp init.vim ~/.config/nvim
    cd ..
else
    echo "Not in the directory of the git repo, need to be inside of it for script to work"
fi
