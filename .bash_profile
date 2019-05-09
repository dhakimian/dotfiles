[[ -s ~/.bashrc ]] && source ~/.bashrc

if [ "$TERM" != "dumb" ]; then
	export CLICOLOR=1
	export LSCOLORS=ExGxFxDxCxDxDxhbhdacEc
	export GREP_OPTIONS='--color=auto'
fi
