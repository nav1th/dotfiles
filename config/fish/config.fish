set fish_greeting
if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end
if test -f /usr/local/bin/starship 
    if test -x /usr/local/bin/starship
        starship init fish | source
    end
else if test -f /usr/bin/starship 
    if test -x /usr/bin/starship
        starship init fish | source
    end
end
if test -n $TMUX
    tmux
end
