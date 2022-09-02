#!/usr/bin/fish
if test -x /usr/bin/nvim 
    function vimcnf
        nvim ~/.config/nvim/init.vim
    end
else
    function vimcnf
        vim ~/.config/nvim/init.vim
    end
end
