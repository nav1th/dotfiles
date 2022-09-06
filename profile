export PATH=$PATH:~/.local/bin:~/.cargo/bin
export TERM=screen-256color
export EDITOR='nvim'
export VISUAL='nvim'
if [ -x "$HOME/.cargo/bin/lsd" ]; then
    alias ls=lsd
fi
. "$HOME/.cargo/env"

