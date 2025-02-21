set fish_greeting

if [ ! $TMUX ]
    neofetch --colors 15 9 9 9 15 15 --ascii_colors 8 9 --block_range
end

# Starship prompt
if test -f /usr/local/bin/starship && test -x /usr/local/bin/starship
    if test -x /usr/local/bin/starship
        starship init fish | source
    end
else if test -f /usr/bin/starship && test -x /usr/bin/starship
    if test -x /usr/bin/starship
        starship init fish | source
    end
end


