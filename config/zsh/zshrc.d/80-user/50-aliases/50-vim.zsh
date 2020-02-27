# Vim and neovim.

# Use neovim instead of vim if available.
if (( $+commands[nvim] )) ; then
	alias vim="nvim"
	alias vimdiff="nvim -d"
	alias view="nvim -R"
fi

# vim with saved session
if (( $+commands[vim] )) ; then
	alias vv="vim -S"
fi
