#!/bin/bash

USER=`who | awk '{print $1}'`
HOME=/home/$USER
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
    if cat /etc/os-release 2>/dev/null 1>&2; then
        distro=`cat /etc/os-release | awk -F '=' '{print $2}' | head -n3 | tail -n1`
    else
        distro=`cat /etc/lsb-release | awk -F '=' '{print $2}' | head -n1`
    distro=`echo ${distro,,}`
    fi
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
            msg "updating $distro repositories"
            if pacman -Syy 2>/dev/null 1>&2; then
                good "repositories sucessfully updated"
                msg "installing zsh..."
                if pacman -S zsh 2>/dev/null 1>&2; then
                    good "zsh sucessfully installed"
                else
                    error "zsh could not be installed run 'pacman -S zsh' to find out why"
                    exit 1
                fi
            else
                error "repositories failed to be updated run 'pacman -Syy' to find out why"
                exit 1
            fi
            ;;
        fedora)
            msg "updating $distro repositories"
            if dnf check-update 2>/dev/null 1>&2; then
                good "repositories sucessfully updated"
                msg "installing zsh..."
                if dnf install zsh 2>/dev/null 1>&2; then
                    good "zsh sucessfully installed"
                else
                    error "zsh could not be installed run 'dnf install zsh' to find out why"
                    exit 1
                fi
            else
                error "repositories failed to be updated run 'dnf check-update' to find out why"
                exit 1
            fi
            ;;
        debian | ubuntu | kali | raspian)
            msg "updating $distro repositories"
            if apt-get update 2>/dev/null 1>&2; then
                good "repositories sucessfully updated"
                msg "installing zsh..."
                if apt-get install zsh 2>/dev/null 1>&2; then
                    good "zsh sucessfully installed"
                else
                    error "zsh could not be installed run 'apt-get install zsh' to find out why"
                    exit 1
                fi
            else
                error "repositories failed to be updated run 'apt-get update' to find out why"
                exit 1
            fi
            ;;
        *)
            warn "could not identify distro, running script as if it's debian based"
            if ! apt -v 2>/dev/null 1&>2; then
                error "apt could not be detected, please edit the code to install zsh using your package manager"
                exit 1
            fi
            msg "updating $distro repositories"
            if apt-get update 2>/dev/null 1>&2; then
                good "repositories sucessfully updated"
                msg "installing zsh..."
                if apt-get install zsh 2>/dev/null 1>&2; then
                    good "zsh sucessfully installed"
                else
                    error "zsh could not be installed run 'apt-get install zsh' to find out why"
                    exit 1
                fi
            else
                error "repositories failed to be updated run 'apt-get update' to find out why"
                exit 1
            fi
            ;;
    esac
    msg "installing nodejs"
    if wget https://nodejs.org/dist/v14.18.1/node-v14.18.1-linux-x64.tar.xz -O nodejs; then
        mkdir /opt 2>/dev/null #creates /opt if it hasn't already been created
        rm -rf /opt/node* #removes any previous instances of nodejs in opt
        tar -xvf nodejs -C /opt 2>/dev/null 1>&2
        mv /opt/node* /opt/nodejs
        ls -l /opt
        sleep 100
        if ln -s /opt/nodejs/bin/node /usr/bin/node 2>/dev/null; then
            "failed to install nodejs, is it already installed elsewhere on the system?"
            exit 1
        fi
    else
        error "failed to download nodejs"
        exit 1
    fi
    #git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    #echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y 2>/dev/null 1>&2
    mv ~/zsh-syntax-highlighting .zsh-syntax-highlighting
    mkdir -p $HOME/.config/nvim/ 2>/dev/null
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubUSERcontent.com/junegunn/vim-plug/master/plug.vim 2>/dev/null 1>&2
    chown $USER "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
}
copy_to_conf(){
    tar -xvf conf.tar conffiles 2>/dev/null 1>&2
    cd conffiles 2>/dev/null 
    if [ $? -eq 0 ]; then
        cp .profile .zshrc $HOME
        cp starship.toml /home/$USER/.config
        cp init.vim /home/$USER/.config/nvim
        chown -R $USER $HOME/.profile $HOME/.zshrc $HOME/.config
        cd ..
        rm -rf conffiles
    else
        error "Not in the directory of the git repo, need to be inside of it for script to work"
    fi
}

check_root
check_distro
check_internet
install_software
copy_to_conf

