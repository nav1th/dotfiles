export PATH=$PATH:~/.local/bin:~/.cargo/bin
export EDITOR='nvim'
export VISUAL='nvim'
alias svim='sudo -E nvim'
alias zshconfig="vim ~/.zshrc"
if [ -x "$HOME/.cargo/bin/lsd" ]; then
    alias ls=lsd
fi
. "$HOME/.cargo/env"
