export PATH=$PATH:~/.local/bin:~/.cargo/bin
export EDITOR='vim'
export VISUAL='vim'
export XDG_CONFIG_DIRS='/etc/xdg'
alias svim='sudo -E vim'
alias snvim='sudo -E nvim'
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias mkd="mkdir"
if ls ~/.cargo/bin/lsd 2>/dev/null 1>&2; then
    alias ls=lsd
fi

. "$HOME/.cargo/env"
