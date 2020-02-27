# Prepare setting basic environment variables.
#
# NOTE:
# Man page tell us to use `typeset -U PATH path`, but this does
# not work in `for` loop.
# It is necessary to explicitly make them global, by doing
# `typeset -gU PATH path`, `typeset -xU PATH path`, or something
# like that.
# See <https://mastodon.cardina1.red/@lo48576/99816229749927704>
# for detail.
() {
	setopt localoptions glob_assign
	typeset -gU PATH path

	typeset -xT LD_LIBRARY_PATH ld_library_path
	typeset -U LD_LIBRARY_PATH ld_library_path

	typeset -xT LD_PRELOAD ld_preload
	typeset -U LD_PRELOAD ld_preload

	typeset -gxU INCLUDE include
	export INCLUDE
}

# Set `$SUDO_PATH`.
if (( $EUID == 0 )) ; then
	typeset -xT SUDO_PATH sudo_path
	typeset -U SUDO_PATH sudo_path
	sudo_path=(
		/usr/local/sbin(N-/)
		/usr/sbin(N-/)
		/sbin(N-/)
		$sudo_path
		)
	sudo_path=( ${^sudo_path}(N-/^W) )
	path+=( $sudo_path )
fi

# Set `$MANPATH`.
typeset -gU MANPATH manpath
