set fish_greeting

neofetch --colors 15 9 9 9 15 15 --ascii_colors 8 9 --block_range

if test -f /usr/local/bin/starship 
    if test -x /usr/local/bin/starship
        starship init fish | source
    end
else if test -f /usr/bin/starship 
    if test -x /usr/bin/starship
        starship init fish | source
    end
end

if not pgrep --full ssh-agent | string collect >/dev/null
  eval (ssh-agent -c)
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/navith/.ghcup/bin $PATH # ghcup-env
