# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# the pattern "**" used in a pathname expansion context will match all files
# and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Functions ##

function latex_init() {
    if [ $# -eq 1 ]
    then
        git clone git@github.com:mugamma/latex-macros.git
        cp latex-macros/doc.tex $1
    elif [ $# -eq 2 ]
    then
        git clone -b $1 git@github.com:mugamma/latex-macros.git
        cp latex-macros/doc.tex $2
    else
        echo "usage: latex_init [branch-name] <doc-name.tex>"
        return 0
    fi
        yes | rm -r latex-macros
}

mountcrypt() {
    if [ -z "$1" ]; then
        echo "Usage: mountcrypt <dir.encrypted>"
        return 1
    fi
    
    local encrypted="$1"
    local dir=$(echo $encrypted | sed 's/\..*$//')
    local keyfile="${dir}.key.gpg"
        
    mkdir "$dir"
    
    # Mount with YubiKey
    gpg --decrypt "$keyfile" 2>/dev/null | gocryptfs -q "$encrypted" "$dir"
    
    if [ $? -ne 0 ]; then
        rmdir "$dir" 2>/dev/null
        return 1
    fi
}

umountcrypt() {
    if [ -z "$1" ]; then
        echo "Usage: umountcrypt <dir>"
        return 1
    fi
    
    fusermount -u "$1" && rmdir "$1"
}

## Aliases ##

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias vi='nvim'
alias vim='nvim'
alias ipython='echo $TMUX_PANE && ipython --no-confirm-exit'
alias tp='echo $TMUX_PANE'
alias today="date +%Y%m%d"
alias latest="ls -l *.md | tail -n 1 | awk '{print \$NF}'"

## Path ##

export PATH="$PATH:/home/matin/opt/texlive/2024/bin/x86_64-linux"
export PATH="$PATH:/home/matin/opt/nvim/bin"
export PATH="$PATH:/home/matin/opt/starship/"
export PATH="$PATH:/home/matin/opt/pixi/bin"
export PATH="$PATH:/home/matin/opt/cmake/bin"
export PATH="$PATH:/home/matin/opt/atuin/bin"
export PATH="$PATH:/home/matin/opt/claude/bin"
export PATH="$PATH:/home/matin/opt/tmux/bin"
export PATH="/home/matin/.pixi/bin:$PATH"

## Initialize various things ##

stty -ixon

# starship
eval "$(starship init bash)"
export STARSHIP_CONFIG=/home/matin/data/starship/config.toml

source /usr/share/bash-completion/completions/git

export EDITOR=nvim # for vipe

eval "$(pixi completion --shell bash)"

eval "$(atuin init bash --disable-up-arrow)"

. "$HOME/opt/atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh






