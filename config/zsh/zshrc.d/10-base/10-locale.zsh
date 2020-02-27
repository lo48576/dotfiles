# Set `$LANG`.
() {
	# Force `LANG=C` for root.
	if (( $EUID == 0 )) ; then
		LANG=C
		return
	fi

	# Use default on terminal multiplexer.
	# This is because the multiplexer will be attached from various terminal emulators.
	local multiplexer
	() {
		if [[ -n $TMUX ]] ; then
			multiplexer=tmux
			return
		fi
		case $TERM in
			tmux|tmux-*)
				multiplexer=tmux
				return
				;;
			screen|screen-*)
				multiplexer=screen
				return
				;;
		esac
	}
	if [[ -n $multiplexer ]] ; then
		# Running on terminal multiplexer.
		return
	fi

	# Use `LANG=C` for agetty.
	if [[ $TERM == linux ]] ; then
		LANG=C
		return
	fi

	# If no special rules are applicable, use default.
	return
}
export LANG
