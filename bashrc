# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias julia='julia --color=yes'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'
alias ipython='ipython --no-confirm-exit'
alias tp='echo $TMUX_PANE'

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

alias today="date +%Y%m%d"
alias latest="ls -l *.md | tail -n 1 | awk '{print \$NF}'"

alias scratch="vi scratch.md"


alias ijulia='julia --project=. -e "using IJulia; notebook()"'

# starship
export PATH="/home/matin/opt/starship/:$PATH"
eval "$(starship init bash)"
export STARSHIP_CONFIG=/home/matin/data/starship/config.toml
 
stty -ixon

source /usr/share/bash-completion/completions/git


export PATH="$PATH:/home/matin/opt/texlive/2024/bin/x86_64-linux"

export PATH="/home/matin/opt/nvim/bin:$PATH"

export PATH="/home/matin/opt/processing/processing-4.3.3/java/bin:$PATH"

export PATH="/home/matin/opt/clojure/bin:$PATH"

export PATH="/home/matin/opt/cursor:$PATH"

export JAVA_HOME="/home/matin/opt/processing/processing-4.3.3/java/bin"

alias vim='nvim'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/matin/opt/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/matin/opt/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/matin/opt/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/matin/opt/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

