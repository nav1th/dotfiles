#!/bin/bash
zshsynhigh="zsh-syntax-highlighting"
zshdir="$home/.zsh"
install_zsh(){
    msg "installing zsh"
    if package_install zsh; then
        good "zsh installed"
	return 0
    fi
}
install_zsh_syn_high(){
    msg "downloading $zshsynhigh files. "
    if git clone https://github.com/zsh-users/$zshsynhigh.git $zshdir/$zshsynhigh 2>/dev/null 1>&2; then
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
