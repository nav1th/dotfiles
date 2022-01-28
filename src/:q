#!/bin/bash
zshsynhigh="zsh-syntax-highlighting"
zshautosugg="zsh-autosuggestions"
zshdir="$home/.zsh"
install_zsh(){
    if package_install zsh; then
        return 0
    else
        return 1
    fi
}
install_zsh_syn_high(){
    msg "downloading $zshsynhigh files... "
    if git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zshdir/$zshsynhigh 2>/dev/null 1>&2; then
        good "$zshsynhigh files downloaded"
        msg "installing $zshsynhigh"
        #mv $zshsynhigh $home/.$zshsynhigh 2>/dev/null &&
        chown -R $user:$user $home/.$zshsynhigh 2>/dev/null 
        good "$zshsynhigh installed"
        return 0
    else
        err "failed to download $zshsynhigh files. are you still connected to the net?"
        return 1
    fi
}
install_zsh_autosugg(){
    msg "downloading $zshautosugg files... "
    if git clone https://github.com/zsh-users/zsh-autosuggestions $zshdir/$zshautosugg 2>/dev/null 1>&2; then
        good "$zshautosugg files downloaded"
        msg "installing $zshautosugg"
        #mv $zshsynhigh $home/.$zshsynhigh 2>/dev/null &&
        chown -R $user:$user $home/.$zshautosugg 2>/dev/null 
        good "$zshautosugg installed"
        return 0
    else
        err "failed to download $zshautosugg files. are you still connected to the net?"
        return 1
    fi
}
