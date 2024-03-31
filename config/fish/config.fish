set fish_greeting
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


