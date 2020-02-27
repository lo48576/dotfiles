# App-specific configs.

# Tmux. {{{1
{
	if (( $+commands[tmux] )) && [[ -n $TMUX ]] ; then
		# Set window title.
		# #T: pane_title
		# #W: window_name
		# #S: session_name
		LANG=C.utf8 tmux set set-titles-string '#T[[#W]] #S - tmux'
	fi
}

# vim: set foldmethod=marker :
