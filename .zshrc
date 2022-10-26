
[[ -z "$PS1" ]] && return  #Don't execute this file for non-interactive shells

#Add in other completions (specifically docker completion at this time, which is symlinked from /Applications/Docker.app/Contents/Resources/etc/)
fpath=(~/.zsh/completion /opt/local/share/zsh/site-functions $fpath)

# The following lines were added by compinstall
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
zstyle ':completion:*' menu select
########################
export PS1=$'%{\e[0;31m%}%(?..\[$?\])%(!.%{\e[01;31m%}.%{\e[01;33m%}%n@)%m%{\e[01;34m%} %~ %%%{\e[00m%} '

bindkey -v

autoload -Uz edit-command-line
zmodload zsh/complist
bindkey -M menuselect "^J" .accept-line
bindkey -M menuselect "^M" .accept-line
#( [Z = Shift-Tab )
bindkey -M menuselect '^[[Z' reverse-menu-complete
#bindkey -M menuselect "\e" send-break # ^C already does this
bindkey -M menuselect "\e" accept-line
nop() {}
zle -N edit-command-line
zle -N nop
bindkey -M vicmd V edit-command-line
bindkey -M vicmd "\e" nop
bindkey -M vicmd "u" undo
bindkey -M vicmd "^R" redo
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^S" history-incremental-search-forward
#bindkey -M viins "???" redisplay
#bindkey -M vicmd "???" redisplay
bindkey -M viins "\e." insert-last-word
bindkey -M viins "\e_" insert-last-word
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^Y" yank
bindkey -M viins "\ey" yank-pop
bindkey -M vicmd "Y" vi-yank-eol
# yank means different things to vi and shell..

setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB
unsetopt NULL_GLOB
setopt GLOB_COMPLETE
setopt PROMPT_SUBST
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt RM_STAR_WAIT
unsetopt AUTO_REMOVE_SLASH

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
#HISTORY_IGNORE="(   *|t|rm -r*|rm -fr*|sudo rm -r*|sudo rm -fr*)"
#EDITOR=`which vi`
REPORTTIME=30

#export PATH="$PATH:/opt/local/bin:$HOME/bin"
#export PATH="/opt/local/bin:$PATH:$HOME/bin"
export PATH="/opt/local/libexec/gnubin:/opt/local/bin:$PATH:$HOME/bin"

export EDITOR=`which nvim`
export CLICOLOR=1
export LSCOLORS=ExGxFxDxCxDxDxhbhdacEc
export ZLS_COLORS="$LS_COLORS"
export GREP_OPTIONS='--color=auto'
export COLORTERM=yes
eval `gdircolors ~/.dir_colors`

#eval "$($HOME/.rakudobrew/bin/rakudobrew init -)"

alias vi='nvim'
alias vimdiff='nvim -d'
alias sed='gsed'
alias ls='gls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ltr='ls -ltr'
#alias df='df -h'
alias t='true'
#alias diff='colordiff'
########################


function mkgitline {
	git status > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		gitRepo=$(git config --get remote.origin.url | sed -r 's/.*\/(.*)\.git/\1/')
		gitBranch=$(git branch --show-current)
		echo -en "$gitRepo \u2387 $gitBranch"
	else
		echo -n ''
	fi
}

if [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
	source "${HOME}/.iterm2_shell_integration.zsh"
	iterm2_print_user_vars() {
		iterm2_set_user_var gitLine "$(mkgitline)"
	}
fi
