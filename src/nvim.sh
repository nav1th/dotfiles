#!/bin/bash
install_nvim(){
    if ! nvim -v 2>/dev/null 1>&2; then
	msg "downloading nvim files..."
        if curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 2>/dev/null; then
	    msg "installing nvim"
	    chmod 755 nvim.appimage
	    if ! su $user -c "./nvim.appimage" -v 2>/dev/null 1>&2; then
		./nvim.appimage --appimage-extract  2>/dev/null 1>&2
		./squashfs-root/AppRun --version 2>/dev/null 1>&2
		mv squashfs-root /opt/nvim && ln -s /opt/nvim/AppRun /usr/bin/nvim 2>/dev/null
	    else
		mv nvim.appimage /opt/nvim && ln -s /opt/nvim /usr/bin/nvim 
	    fi
	    if ! find $home/.local/share/nvim/site/autoload/plug.vim 2>/dev/null 1>&2; then
		    su $user -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 2>/dev/null 1>&2
	    else 
		err "failed to download nvim files. are you still connected to the net?"
    
	    fi
	fi
    fi
}
