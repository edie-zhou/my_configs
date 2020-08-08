# Edie's .zshrc file

# Starting prompt indicating .bashrc was sourced
echo "$HOME/.zshrc sourced"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Some helpful aliases
# =============================================================================

# aliases for quickly editing configuration files
alias ez='vim ~/.zshrc; source ~/.zshrc'
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
alias gr='git reset'
alias grb='git rebase'
alias grf='git reflog'

# Python aliases
alias p='python'
alias p2='python2'
alias p3='python3'

# Conda aliases
alias sactivate='source activate'

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

# Prompt modifications
# =============================================================================

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Displays current working directory and git branch in prompt
setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
	[[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

	# Exit if not inside a Git repository
	! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

	local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
	local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
	local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
	local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
	local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
	local STAGED="%{$fg[green]%}●%{$reset_color%}"
	
	local -a DIVERGENCES
	local -a FLAGS
	
	local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_AHEAD" -gt 0 ]; then
		DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
	fi
	
	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_BEHIND" -gt 0 ]; then
		DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
	fi
	
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		FLAGS+=( "$MERGING" )
	fi
	
	if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
		FLAGS+=( "$UNTRACKED" )
	fi
	
	if ! git diff --quiet 2> /dev/null; then
		FLAGS+=( "$MODIFIED" )
	fi
	
	if ! git diff --cached --quiet 2> /dev/null; then
		FLAGS+=( "$STAGED" )
	fi

	local -a GIT_INFO
	GIT_INFO+=( "\033[38;5;15m±" )
	[ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
	[[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
	[[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
	GIT_INFO+=( "\033[38;5;15m$GIT_LOCATION%{$reset_color%}" )
	echo "${(j: :)GIT_INFO}"

}

# Use ❯ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1='
$(ssh_info)%{$fg[magenta]%}%~%u $(git_info)
%(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.❯)%{$reset_color%} '


# Misc.
# =============================================================================

