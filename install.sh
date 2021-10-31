#!/bin/bash
user=$(who | awk '{print $1}' | head -n1)
home="/home/$user"
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
        exit 1
    fi
}
check_location(){
    basename="$(dirname $0)"
    realpath="$(realpath $basename)"
    if [$realpath -ne $PWD 2>/dev/null];then
        error "need to be in the script directory to run script"
        exit 1
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
            install="-S"
            ;;
        fedora)
            pm="dnf"
            update="check-update" 
            install="install"
            ;;
        debian | ubuntu | kali | raspian)
            pm="apt"
            update="update" 
            install="install -y"
            ;;
        void)
            pm="xbps"
            install="-install"
            update="-update"
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
check_internet(){
    tool=ping
    if ! $tool -c 1 8.8.8.8 >/dev/null 2>&1; then
        error "Not connected to the internet"
        exit 1
    fi
}
packages_update(){
    msg "updating $distro repositories"
    if $tool $args 2>/dev/null 1>&2; then
        good "repositories updated"
    else
        error "repositories failed to be updated run $tool $args' to find out why"
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
install_nodejs(){
    msg "installing nodejs"
    if sh -c "$(curl -fsSL https://starship.rs/install.sh)" && package install nodejs 2>/dev/null 1>&2; then
        good "nodejs installed"
    else
        warn "nodejs failed to install"
    fi
}
install_vim(){
    if ! nvim -v 2>/dev/null 1>&2; then
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 2>/dev/null
        chmod 755 nvim.appimage
        if ! su $user -c "./nvim.appimage" -v 2>/dev/null 1>&2; then
            ./nvim.appimage --appimage-extract  2>/dev/null 1>&2
            ./squashfs-root/AppRun --version 2>/dev/null 1>&2
            mv squashfs-root /opt/nvim && ln -s /opt/nvim/AppRun /usr/bin/nvim 2>/dev/null
        else
            mv nvim.appimage /opt/nvim && ln -s /opt/nvim /usr/bin/nvim 
        fi
    fi
}
install_zsh(){
    rm  -rf $home/zsh-syntax-highlighting 2>/dev/null
    if ! ls $home/.zsh-syntax-highlighting 2>/dev/null 1>&2; then
        msg "installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 2>/dev/null 1>&2
        mv zsh-syntax-highlighting $home/.zsh-syntax-highlighting
        chown -R $user $home/.zsh-syntax-highlighting
        good "zsh-syntax-highlighting installed"
    else
        msg "zsh-syntax-highlighting already installed"
    fi
}
install_software(){
    mkdir /opt 2>/dev/null #creates /opt if it hasn't already been created
    can_use_pm=config_packageman
    packages_update
    install_nodejs
    install_zsh-syn-high
    install_vim
    msg "installing starship prompt..."
    if sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y 2>/dev/null 1>&2;then 
        good "starship installed"
    else
        warn "starship failed to install"
    fi
    curl -fLo "${XDG_DATA_home:-$home/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>/dev/null 1>&2
    chown $user "${XDG_DATA_home:-$home/.local/share}"/nvim/site/autoload/plug.vim
}
copy_to_conf(){
    msg "extracting configuration files"
    if tar -xvf conf.tar conffiles 2>/dev/null 1>&2;then
        good "configuration files extracted"
        msg "making configuriation directories"
        if mkdir -p $home/.config/nvim/ 2>/dev/null 1>&2; then
            good "nvim configuation directory made"
        fi
        cd conffiles
        if cp .profile .zshrc $home;then
            good "copied .zshrc to $home"
            good "copied .profile to $home"
        fi
        if cp starship.toml $home/.config;then
            good "copied starship.toml to $home/.config"
        fi
        if cp init.vim $home/.config/nvim; then
            good "copied init.vim to $home/.config/nvim"
        fi
    else
        error "failed to extract configuration files"
        exit 1
    fi
}
finishing_touch()(
    chown -R $user $home/.profile $home/.zshrc $home/.config 2>/dev/null
    cd ..
    rm -rf conffiles zsh-syntax-highlighting 2>/dev/null 
    usermod --shell /usr/bin/zsh $user 2>/dev/null 1>&2
    good "done"
    exit 0
)

check_root 
check_location
check_distro
check_internet
install_software
copy_to_conf
finishing_touch
