# gentoo

# emerge
if (( $+commands[emerge] )) ; then
	# When you run "udon world" or "udon @world", your world will be overspread with udon noodle!
	(( $+commands[emerge] )) && alias udon="sudo emerge -uDNv --keep-going"
	true
fi
