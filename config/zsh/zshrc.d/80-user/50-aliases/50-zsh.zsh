# Zsh.

# zmv
{
	autoload -Uz zmv
	alias zmv="noglob zmv"
	alias zmvw="noglob zmv -W"
	alias zcp="noglob zmv -C"
	alias zcpw="noglob zmv -C -W"
	alias zln="noglob zmv -L"
	alias zlnw="noglob zmv -L -W"
}

# history
{
	alias hist-all="history -E 1"
	alias histgrep="history -E 1 | grep"
}

# misc
{
	alias where="command -v"
	alias j="jobs -l"

	# restart zsh
	alias zz="exec zsh"

	# Quit zsh like vim.
	alias :q="exit"
	# I sometimes press 'q' with Shift because ':' is Shift-; ...
	alias :Q="exit"

	# Edit file with vim like vim.
	if [[ -n ${EDITOR:-} ]] ; then
		alias :e="$EDITOR"
	fi
}
