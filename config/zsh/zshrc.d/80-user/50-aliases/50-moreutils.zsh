# moreutils

# ts
if (( $+commands[ts] )) ; then
	# `ts` (moreutils).
	alias ts="command ts '"$'\e'"[34m[%Y-%m-%d %H:%M:%S]"$'\e'"[0m'"
	alias tss="command ts -s '"$'\e'"[34m[%H:%M:%S]"$'\e'"[0m'"
	alias ts-nocolor="command ts '[%Y-%m-%d %H:%M:%S]'"
	alias tss-nocolor="command ts -s '[%H:%M:%S]'"
fi
