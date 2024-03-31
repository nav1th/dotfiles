#!/usr/bin/env bash
USER=$(who | awk '{print $1}' | head -n1)
HOME="/home/$USER"
SCRIPT_NAME="$(dirname $0)"
SCRIPT_DIR="$(realpath $SCRIPT_NAME)"
ROOT_DIR="${SCRIPT_DIR%/*}"
DOTFILES=$ROOT_DIR/res
DISTRO=`cat /etc/os-release | grep -v VERSION | grep ID | awk -F '=' '{print $2}'`
declare -a PM_PACKAGES=("zsh" "tmux" "vim")
declare -a CARGO_PACKAGES=("lsd")

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
    ./tools/runme.sh [FLAGS] 

FLAGS:
    -l, --link              link dotfiles in correct places
    -i, --install           Install specified software
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

main(){
    if [[ $# -gt 0 ]]; then
        for flag in $@; do
            case $flag in
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
                -l|--link)
      
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
