# Edie's .bashrc file

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Starting prompt indicating .bashrc was sourced
echo "$HOME/.bashrc sourced"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Some helpful aliases
# =============================================================================

# aliases for quickly editing configuration files
alias ea='vim ~/.bashrc; source ~/.bashrc'
alias ev='vim ~/.vimrc'

# Interactive commands
alias rm='rm -vi' # Add verbose and interactive to rm, cp, mv
alias cp='cp -vi'
alias mv='mv -vi'

# NOTE: can't have spaces in the {} shell glob
# NOTE: there is no '--exclude-dir' option for CTAGS
# Directories and files to exclude for CTAGS and grep
exclude_dirs='\*{.catkin_tools,.private,build,logs,.git}'
exclude_files='\*{tags,.tags,.catkin,.js,.json,.map,.ts,.pyc,.rviz,.so,.o,.cmake,.xml,.ijmap,.html,.svg,.css,.lock,.test,.perspective,.bin,.bnf}'

alias grep='grep -niI --color --exclude-dir='"$exclude_dirs"' --exclude='"$exclude_files"

# create the ctags file
alias CT='ctags -R -f .tags --exclude='"$exclude_dirs"' --exclude='"$exclude_files"''
alias CT..='builtin cd ..  &&  CT  &&  builtin cd -'

# Custom shortcuts
alias clean='rm -f "#"* "."*~ *~ *.bak *.dvi *.aux *.log' # Delete temp files
alias q='exit'
alias c='clear'
alias h='history'
alias cs='clear;ll' # Clear and list
alias p='cat'
alias rf='rm -rf'
alias vim='vim -p' 

# List aliases
alias ll='ls -altrh' # Very comprehensive list
alias la='ls -A'
alias l='ls -CF'

# Apt aliases
alias install='sudo apt-get --yes --force-yes install'
alias search='sudo apt-cache search'

# Git aliases
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gbv='git branch -av'
alias gc='git commit -m'
alias gcv='git commit'
alias gch='git checkout'
alias gd='git diff -w --ignore-blank-lines'
alias gdv='git diff'
alias gf='git fetch'
alias gl='git log --oneline -n 10'
alias gll='git log --all --decorate --graph --oneline'
alias gllv='git log --all --decorate --graph'
alias gm='git merge'
alias gph='git push'
alias gpl='git pull'
alias gs='git status'
alias gst='git stash'
alias gr='git reset'
alias grb='git rebase'
alias grf='git reflog'

# Python aliases
alias p='python'
alias p2='python2'
alias p3='python3'

# Conda aliases
alias sactivate='source activate'

# Libreoffice aliases
alias lwriter='libreoffice --writer'
alias limpress='libreoffice --impress'
alias lcalc='libreoffice --calc'

# powering off and restarting from command line
alias powerdown='poweroff'
alias shutdown='poweroff'
alias restart='reboot'
alias logout='gnome-session-quit --logout --no-prompt'
alias sleeppc='systemctl suspend'

# User-defined bash functions
# =============================================================================

# Set default editor
export EDITOR=vim

# Overwrites cd so every cd is followed by an ls
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

# Detects file type and applies corresponding flags when extracting
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)	tar xjf $1		;;
            *.tar.gz)	tar xzf $1		;;
            *.bz2)		bunzip2 $1		;;
            *.rar)		rar x $1		;;
            *.gz)		gunzip $1		;;
            *.tar)		tar xf $1		;;
            *.tbz2)		tar xjf $1		;;
            *.tgz)		tar xzf $1		;;
            *.zip)		unzip $1		;;
            *.Z)		uncompress $1	;;
            *)			echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Save original user path 
export MY_ORIGINAL_PATH=$PATH

# Change to python env to conda env
use_conda() {
#    export PATH="/home/edie/miniconda3/bin:$PATH"  # commented out by conda initialize
    echo "Conda has been activated"
}

# Change to python env to system env
use_original() {
    if [ -x "$(command -v conda)" ]; then
        source deactivate
    fi
    export PATH=$MY_ORIGINAL_PATH
    echo "Restored original PATH"
    python --version
}


# Default conda init from conda install
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/edie/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/edie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/edie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/edie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Eternal bash history
# =============================================================================

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# leave some commands out of history log
export HISTIGNORE="&:??:[ ]*:clear:exit:logout:ls:ll:bg:fg:history:ls -l:ls -al"

# append to the history file, don't overwrite it
shopt -s histappend

# combine multiline commands into one line in history
shopt -s cmdhist
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# Prompt modifications
# =============================================================================

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Displays current working directory and git branch in prompt
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]\$\[\033[0m\033[0;32m\] \[\033[0m\]'

# Misc.
# =============================================================================

# Add pintos to PATH
# export PATH=$HOME/git/pintos-userprog/pintos/src/utils:$PATH

# Put pintos in PATH
# source /home/edie/git/pintos-userprog/.PINTOS_PATH
# alias pintos-gdb='GDBMACROS=/home/edie/git/pintos-userprog/misc/gdb-macros pintos-gdb'
