# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
if source $ZSH/oh-my-zsh.sh 2>/dev/null; then
    plugins=(git
        colored-man-pages
        python
    )
fi

#zsh-plugins
ZSH_PLUGIN="$HOME/.zsh"
ZSH_SYN_HIGH=$ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGG=$ZSH_PLUGIN/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_SYN_HIGH
source $ZSH_AUTOSUGG

source $HOME/.profile

export TERM="xterm-256color"



 #DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
 #COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

setopt autocd extendedglob nomatch
unsetopt beep
eval "$(starship init zsh)"
if [ "$TMUX" = "" ]; then tmux; fi
