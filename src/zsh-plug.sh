#!/bin/bash
ZSHSYNHIGH="zsh-syntax-highlighting"
ZSHAUTOSUGG="zsh-autosuggestions"
ZSHDIR="$HOME/.zsh"
install_zsh-plug(){
    su $USER -c "mkdir $ZSHDIR"  
    msg "downloading $ZSHSYNHIGH files... "
    if git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSHDIR/$ZSHSYNHIGH 2>/dev/null 1>&2; then
        good "$ZSHSYNHIGH files downloaded"
        msg "installing $ZSHSYNHIGH"
        #mv $ZSHSYNHIGH $home/.$ZSHSYNHIGH 2>/dev/null &&
        chown -R $user:$user $home/.$ZSHSYNHIGH 2>/dev/null 
        good "$ZSHSYNHIGH installed"
    else
        err "failed to download $ZSHSYNHIGH files. are you still connected to the net?"
    fi
    msg "installing $ZSHAUTOSUGG files... "
    if git clone https://github.com/zsh-users/zsh-autosuggestions $ZSHDIR/$ZSHAUTOSUGG 2>/dev/null 1>&2; then
        good "$ZSHAUTOSUGG installed"
        chown -R $user:$user $home/.$ZSHAUTOSUGG 2>/dev/null 
    else
        err "failed to download $ZSHAUTOSUGG files. are you still connected to the net?"
    fi
}
