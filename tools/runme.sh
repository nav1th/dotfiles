#!/usr/bin/env bash
set -e
USER=$(who | awk '{print $1}' | head -n1)
HOME="/home/$USER"
SCRIPT_NAME="$(dirname $0)"
SCRIPT_DIR="$(realpath $SCRIPT_NAME)"
ROOT_DIR="${SCRIPT_DIR%/*}"
DOTFILES=$ROOT_DIR/res
DISTRO=`cat /etc/os-release | grep -v VERSION | grep ID | awk -F '=' '{print $2}'`
declare -a PM_PACKAGES=("zsh" "tmux" "vim")
declare -a CARGO_PACKAGES=("lsd")
source src/zsh-plug.sh
source src/nodejs.sh
source src/nvim.sh

good(){
    printf "\033[92;1mOK: $1\033[0m\n"
}
msg(){
    printf "\033[1m-->>: $1\033[0m\n"
}
go_ahead(){
    printf "\033[1m-->>: $1 (y|N): "
    read answer
    printf "\033[0m"
    case $answer in
        y|Y|[y,Y][e,E][s,S])
            return 0
            ;;
        n|N|[n,N][o,O]|*)
            return 1
            ;;
    esac
}

warn(){
    printf >&2 "\033[93;1mWARNING: $1\033[0m\n"
}
error(){
    printf >&2 "\033[91;1mERROR: $1\033[0m\n"
}
 
usage() { 
    cat 1>&2 <<EOF
USAGE:
    ./runme.sh [FLAGS] 

FLAGS:
    -c, --configure         Configure dotfiles in correct places
    -i, --install           Install specified software
    -b, --backup            Backup dotfiles to this repo
    -h, --help              Prints help information

EOF
}
 

check_location(){
    if [ "$ROOT_DIR" = `pwd -P` ];then
        return 0
    else
        error "need to be in the script directory to run script"
        return 1
    fi
}
check_internet(){
    tool=ping
    msg "checking internet connection..."
    if ! $tool -c 4 8.8.8.8 2>/dev/null 1>&2; then
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
    for i in "${PM_PACKAGES[@]}"
    do
        package_install $i
    done
    #install_nodejs
    #install_nvim
    if zsh --version 2>/dev/null 1>&2; then
        install_zsh-plug
    fi
    msg "installing starship prompt..."
    if sh -c "$(curl -fssl https://starship.rs/install.sh)" -- -y 2>/dev/null 1>&2;then 
        good "starship installed"
    else
        error "starship failed to install"
    fi
    msg "installing rust..."
    if sh -c "$(curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf)" -- -y 2>/dev/null 1>&2;then
        good "rust installed"
    else
        error "rust failed to install"
    fi

}
copy_files(){
    msg "copying $1 to $2"
    if [ -d $1 ]; then
        if cp -TR $1 $2 2>/dev/null ;then
            good "copied $1 to $2"
            chown -R $USER:$USER $2 
        else
            error "failed to copy $1 to $2"
        fi
    else
        if cp $1 $2 2>/dev/null ;then
            good "copied $1 to $2"
            chown -R $USER:$USER $2 
        else
            error "failed to copy $1 to $2"
        fi
    fi
}
configure(){
    cd $DOTFILES
    copy_files .zshrc $HOME
    copy_files starship.toml $HOME/.config
    copy_files .profile $HOME
    copy_files .vimrc $HOME
    copy_files .tmux.conf $HOME
    copy_files nvim $HOME/.config/nvim
    copy_files i3 $HOME/.config/i3
    copy_files polybar $HOME/.config/polybar
    copy_files fish $HOME/.config/fish
    copy_files kitty $HOME/.config/kitty
    cd ..
	return 0
}
backup(){
    cd $DOTFILES
    copy_files $HOME/.zshrc . 
    copy_files $HOME/.config/starship.toml .
    copy_files $HOME/.profile . 
    copy_files $HOME/.vimrc .
    copy_files $HOME/.tmux.conf .
    copy_files $HOME/.config/nvim/init.vim nvim
    copy_files $HOME/.config/i3/config i3
    copy_files $HOME/.config/polybar/launch.sh polybar
    copy_files $HOME/.config/polybar/config polybar
    copy_files $HOME/.config/fish/* fish
    copy_files $HOME/.config/kitty/kitty.conf kitty
    cd ..
    return 0
}
main(){
    if [[ $# -gt 0 ]]; then
        for flag in $@; do
            case $flag in
                -c|--configure)
                    if check_location; then
                        if go_ahead "Are you sure you want to install dotfiles (THIS WILL REPLACE DOTFILES WITHIN YOUR HOME DIRECTORY)?"; then
                            configure
                        else
                            exit 0
                        fi
                    else
                        exit 1
                    fi
                    ;;
                -i|--install)
                    if [ $EUID -eq 0 ];then
                        if check_location; then
                            config_packageman
                        else
                            exit 1
                        fi
                        if check_internet;then
                            install_software
                        fi
                    else
                        error "must be root to install... exiting..."
                        exit 1
                    fi
                    ;;
                -b|--backup)
                    if check_location; then
                        if go_ahead "Are sure you want to backup files (THIS WILL REPLACE DOTFILES IN THIS REPO)?"; then
                            backup
                        else
                            exit 0
                        fi
                    else
                        exit 1
                    fi
                    ;; 
                -h|--help|*)
                    usage
                    exit 0
                    ;;
            esac
        done
    else 
        usage
        exit 0
    fi
}
main $@
