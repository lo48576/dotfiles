# tmux.
if [ -n "${XDG_RUNTIME_DIR:-}" ] ; then
	export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"
fi
