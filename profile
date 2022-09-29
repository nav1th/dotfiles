export PATH=$PATH:~/.local/bin:
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH=$PATH:~/.cargo/bin
fi
export TERM=screen-256color
export EDITOR='nvim'
export VISUAL='nvim'
if [ -x "$HOME/.cargo/bin/lsd" ]; then
    alias ls=lsd
fi
if [ -x "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
