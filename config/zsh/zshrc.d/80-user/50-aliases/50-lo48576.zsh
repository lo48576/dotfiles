# lo48576 utils

# autmux
{
	#autoload -Uz oktmux
	(( $+commands[autmux] )) && alias ::='autmux '
	true
}

# sync
{
	# Don't sync, feel.
	alias feel="sync ; sync ; sync"
}
