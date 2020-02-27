# Set appropriate locale for session type.
# This script should be run after default `$LANG` is set.

# Do not touch `$LANG` on tmux.
if [ -n "${TMUX:-}" ] ; then
	# Note that zsh will treat `(` and `=` specially.
	if [ \( "${XDG_SESSION_CLASS:-}" \== user \) -a \( "${XDG_SESSION_TYPE:-}" \== tty \) ] ; then
		# Currently, maybe on tty (virtual console) or over SSH.
		if [ -z "$SSH_CLIENT" ] ; then
			# Maybe on tty.
			export LANG=C
		fi
	fi
fi

# Set `$LC_*`.
# `LC_TIME=C` changes datetime format to `MM/DD/YY`.
