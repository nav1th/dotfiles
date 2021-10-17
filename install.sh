#!/bin/bash
good(){
    printf "\033[92;1mOK: $1\033[0m\n"
}
msg(){
    printf "\033[1m-->>: $1\033[0m\n"
}

warn(){
    printf "\033[93;1mWARNING: $1\033[0m\n"
}
error(){
    printf "\033[91;1mERROR: $1\033[0m\n"
}
sol(){
    printf "\033[94;1mTRY: $1\033[0m\n"
}

check_root(){
    id=`id -u`
    if [ $id -ne 0 ]; then
        error "you're not root"
        exit 1
    fi
}

check_distro(){
    distro=`cat /etc/*release | awk -F '=' '{print $2}' | head -n3 | tail -n1`
    distro=`echo ${distro,,}`
}
check_internet(){
    tool=ping
    if ! $tool -c 1 8.8.8.8 >/dev/null 2>&1; then
        error "Not connected to the internet"
        exit 1
    fi
}
install_software(){
    case $distro in
        arch | manjaro)
            pacman -Syy --noconfirm zsh neovim zsh-syntax-highlighting 2>/dev/null 1>&2
            ;;
        fedora)
            dnf check-update
            dnf install -y zsh neovim zsh-syntax-highlighting 2>/dev/null 1>&2
            ;;
        debian | ubuntu | *)
            apt update 2>/dev/null 1>&2
            apt install -y zsh neovim 2>/dev/null 1>&2
            ;;
    esac
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

}
copy_to_conf(){
    user=`who | awk '{print $1}'`
    tar -xvf conf.tar.gz conffiles 2>/dev/null
    cd conffiles 2>/dev/null 
    if [ $? -eq 0 ]; then
        cp .profile .zshrc /home/$user
        cp starship.toml /home/$user/.config
        cp init.vim /home/$user/.config/nvim
        cd ..
        rm -rf conffiles
    else
        error "Not in the directory of the git repo, need to be inside of it for script to work"
    fi
}

#check_root
#check_distro
#check_internet
#install_software
copy_to_conf

