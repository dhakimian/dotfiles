# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

#if [ -f $HOME/.dir_colors ]; then
#    eval `dircolors $HOME/.dir_colors`
#elif [ -f $HOME/.dircolors ]; then
#    eval `dircolors $HOME/.dircolors`
#elif [ -f /etc/DIR_COLORS ]; then
#    eval `dircolors /etc/DIR_COLORS`
#else
#    eval `dircolors`
#fi
export GREP_OPTIONS='--color=auto'
#export EDITOR="vim";
export EDITOR="nvim";
HISTCONTROL="${HISTCONTROL}ignoredups:ignorespace"

stty stop ""
shopt -s extglob
set -o vi
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi 'v' #unbind lowercase v in command mode
bind -m vi 'V: edit-and-execute-command' #rebind it to upper V

#alias ls='ls -G'

#alias ls='ls --color=auto'
#alias ll='ls -la'
#alias la='ls -A'
#alias l='ls -CF'
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

function returncode
{
  returncode=$?
  [ $returncode == 0 ] && echo "" || echo "[$returncode]"
}
if [ $EUID -eq 0 ]; then
    export PS1='\[\033[0;31m\]$(returncode)\[\033[01;31m\]\u@\h\[\033[01;34m\] \w >\[\033[00m\] '
else
    export PS1='\[\033[0;31m\]$(returncode)\[\033[01;32m\]\u@\h\[\033[01;34m\] \w >\[\033[00m\] '
fi
