#!/bin/bash

user=$(who | awk '{print $1}' | head -n1)
home="/home/$user"
conf_directory="../res"
nvim_dir="$home/.config/nvim"
source install/zsh.sh
source install/nodejs.sh
source install/nvim.sh


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

check_distro(){
    if cat /etc/os-release 2>/dev/null 1>&2; then
        distro=`cat /etc/os-release | awk -F '=' '{print $2}' | head -n3 | tail -n1`
    else
        distro=`cat /etc/lsb-release | awk -F '=' '{print $2}' | head -n1`
    distro=`echo ${distro,,}`
    fi
}
config_packageman(){
    case $distro in
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
        debian | ubuntu | kali | raspian | zorin )
            pm="apt"
            update="update" 
            install="install -y"
            ;;
        void)
            pm="xbps-install"
            install=""
            update="-install -S "
	    ;;
        *)
            warn "could not identify distro, running script as if it's debian based"
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
    msg "updating $distro repositories"
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
    mkdir /opt 2>/dev/null #creates /opt if it hasn't already been created
    packages_update
    #install_nodejs
    #install_nvim
    if ! zsh --version 2>/dev/null 1>&2; then
        install_zsh
        mkdir $zshdir
        if ! ls $zshdir/$zshsynhigh 2>/dev/null 1>&2; then
            install_zsh_syn_high
        fi
    fi
    msg "installing starship prompt..."
    if sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y 2>/dev/null 1>&2;then 
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
        msg "setting zsh to $user's default shell"
        usermod --shell /usr/bin/zsh $user 2>/dev/null 1>&2
    fi
    if mkdir -p $nvim_dir 2>/dev/null 1>&2; then
        good "nvim configuation directory made"
    fi
    cd $conf_directory
	copy_files .zshrc $home
	copy_files starship.toml $home/.config
	copy_files .profile $home
	copy_files .vimrc $home
	copy_files .tmux.conf $home
    copy_files init.vim $home/.config/nvim
    chown -R $user:$user $home/.zshrc $home/.vimrc $home/.profile $home/.tmux.conf $home/.config/starship.toml $home/.config/nvim
    cd ..
	return 0;
}
main(){
if ! check_root;then
   exit 1 
fi
check_distro
if check_location; then
    config_packageman
    if check_internet;then
        install_software
    fi
    configure
#    su $user -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else 
    exit 1
fi
}
main
