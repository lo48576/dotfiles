# misc, basic

# `LANG=C`
{
	# Always show man page in English.
	alias cman="LANG='C' man"

	#(( $+commands[systemd-cgls] )) && alias systemd-cgls="LANG=C systemd-cgls"
	#(( $+commands[systemd-cgtop] )) && alias systemd-top="LANG=C systemd-cgtop"
	true
}

# mv, cp, rm
{
	# Prevent overwriting files by accident.
	alias mv="LANG=C mv -i"
	alias cp="LANG=C cp -i"
	# See <https://wiki.archlinux.org/index.php/Core_utilities#rm>.
	alias rm="LANG=C rm -I --one-file-system"
}

# du, df
{
	# -h (--human-readable): print sizes in human readable format
	alias du="du -h"
	alias df="df -h"
}

# ps
{
	# a: Lift the BSD-style "only yourself" restriction
	# u: Display user-oriented format
	# x: Lift the BSD-style "must have a tty" restriction
	alias pa="ps aux"
}

# Text searcher
{
	# grep
	alias grep="grep --color=auto"
}

# sudo, su
{
	# enable alias expansion of commands after sudo command with a space after "sudo".
	alias sudo="sudo "

	# -l: use a login shell
	alias su="su -l"
}

# git
{
	alias g="git"
}
