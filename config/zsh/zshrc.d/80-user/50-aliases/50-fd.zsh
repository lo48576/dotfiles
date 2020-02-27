# fd: `find` alternative.
if (( $+commands[fd] )) ; then
	alias fd="command fd --ignore-file '${XDG_CONFIG_HOME:-${HOME}/.config}/fd/ignore'"
	alias fdh="command fd --hidden --no-ignore"
fi
