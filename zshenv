# Load the system default envvars.
if [ -e /etc/profile.env ] ; then
	source /etc/profile.env
fi

# Load `~/.config/profile.d/*.sh`.
() {
	typeset -a profiles
	profiles=( ${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d/*.sh(N.^W,@) )
	for file in $profiles ; do
		source $file
	done
}
export ZDOTDIR="${XDG_CONFIG_HOME:-"${HOME}/.config"}/zsh"

export PATH="${HOME}/.guix-profile/bin:${PATH}"
