# Basic alias
() {
	#LS_COMMON_OPT='--time-style="+%Y-%m-%d %H:%M:%S"'
	# --time-style=long-iso : "+%Y-%m-%d %H:%M" format
	typeset -a common_opts
	common_opts=(
		--time-style=long-iso
		)
	case "${OSTYPE:-}" in
	linux*)
		alias ls="ls --color=auto ${(q)common_opts}"
		;;
	freebsd*|darwin*)
		alias ls="ls -G -w ${(q)common_opts}"
		;;
	esac

	# In case of typo.
	(( $+commands[l] )) || alias l="ls"
	(( $+commands[s] )) || alias s="ls"
	true
}

# Alias with options
{
	# -a (--all): list entries starting with .
	alias la="ls -a"
	# -F (--classify): append file type indicators
	alias lf="ls -F"
	# -l: long listing
	alias ll="ls -l"
	# -h (--human-readable): print sizez in human readable form
	alias llh="ls -lh"
	alias lhl="ls -lh"

	alias lla="ls -la"
	alias lal="ls -la"
	alias llah="ls -lha"
	alias llha="ls -lha"
}
