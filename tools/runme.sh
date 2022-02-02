#!/bin/bash

USER=$(who | awk '{print $1}' | head -n1)
HOME="/home/$USER"
CONFDIR="res"
declare -a PACKAGES=("zsh" "tmux")
DISTRO=`cat /etc/os-release | grep -v VERSION | grep ID | awk -F '=' '{print $2}'`
source src/zsh-plug.sh
source src/nodejs.sh
source src/nvim.sh


good(){
    printf "\033[92;1mOK: $1\033[0m\n"
}
msg(){
    printf "\033[1m-->>: $1\033[0m\n"
}

warn(){
    printf >&2 "\033[93;1mWARNING: $1\033[0m\n"
}
error(){
    printf >&2 "\033[91;1mERROR: $1\033[0m\n"
}

check_root(){
    id=`id -u`
    if [ $id -ne 0 ]; then
        error "you're not root"
        return 1
    fi
    return 0
}
check_location(){
    basename="$(dirname $0)"
    realpath="$(realpath $basename)"
    if [$realpath -ne $PWD 2>/dev/null];then
        error "need to be in the script directory to run script"
        return 1
    fi
    return 0
}
check_internet(){
    tool=ping
    msg "checking internet connection..."
    if ! $tool -c 4 8.8.8.8 >/dev/null 2>&1; then
        error "not connected to the internet"
        return 1
    else 
	good "internet connection working"
    fi
}
config_packageman(){
    case $DISTRO in
        arch | manjaro)
            pm="pacman" 
            update="-Syy" 
            install="-S --noconfirm"
            ;;
        fedora | redhat | centos)
            pm="dnf"
            update="check-update" 
            install="install -y"
            ;;
        debian | ubuntu | kali | raspian | zorin | linuxmint | parrot | popos)
            pm="apt"
            update="update" 
            install="install -y"
            ;;
        void)
            pm="xbps-install"
            install=""
            update="-S"
	    ;;
        *)
            warn "could not identify DISTRO, running script as if it's debian based"
            if  apt -v 2>/dev/null 1&>2; then
                pm="apt"
                update="update"
                install="install -y"
            else
                warn "apt could not be detected, please edit the code to install $software using your package manager"
                return 1
            fi
            ;;
    esac
    return 0
}
packages_update(){
    msg "updating $DISTRO repositories"
    if $pm $update 2>/dev/null 1>&2; then
        good "repositories updated"
    else
        error "repositories failed to be updated run '$pm $update' to find out why"
        return 1
    fi
    return 0
}
package_install(){
    msg "installing $1..."
        if $pm $install $1 2>/dev/null 1>&2; then
            good "$1 installed"
        else
            error "$1 could not be installed run '$pm $install $1' to find out why" 
            return 1
        fi 
    return 0
}
install_software(){
    mkdir /opt 2>/dev/null 
    packages_update
    for i in "${PACKAGES[@]}"
    do
        package_install $i
    done
    #install_nodejs
    #install_nvim
    if ! zsh --version 2>/dev/null 1>&2; then
        install_zsh-plug
    fi
    msg "installing starship prompt..."
    if sh -c "$(curl -fssl https://starship.rs/install.sh)" -- -y 2>/dev/null 1>&2;then 
        good "starship installed"
    else
        warn "starship failed to install"
    fi
}
copy_files(){
    msg "copying $1 to $2"
    if cp $1 $2 2>/dev/null ;then
        good "copied $1 to $2"
    else
        error "failed to copy $1 to $2"
    fi
}
configure(){
    if zsh --version 2>/dev/null 1>&2;then
        msg "setting zsh to $USER's default shell"
        usermod --shell /usr/bin/zsh $USER 2>/dev/null 1>&2
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    fi
    if mkdir -p "$HOME/.config/nvim" 2>/dev/null 1>&2; then
        good "nvim configuation directory made"
    fi
    cd $CONFDIR
    copy_files .zshrc $HOME
    copy_files starship.toml $HOME/.config
    copy_files .profile $HOME
    copy_files .vimrc $HOME
    copy_files .tmux.conf $HOME
    copy_files init.vim $HOME/.config/nvim
    chown -R $USER:$USER $HOME/.zshrc $HOME/.vimrc $HOME/.profile $HOME/.tmux.conf $HOME/.config/starship.toml $HOME/.config/nvim
    cd ..
	return 0;
}
main(){
if ! check_root;then
   exit 1 
fi
if check_location; then
    config_packageman
    if check_internet;then
        install_software
    fi
    configure
    exit 0
#    su $USER -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else 
    exit 1
fi
}
main
