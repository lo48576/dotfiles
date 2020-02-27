# Systemd
if (( $+commands[systemctl] )) ; then
	# `systemctl`.
	alias sysc="systemctl "
	alias sysu="systemctl --user "
	alias setpr="systemctl --runtime set-property "
	alias setupr="systemctl --user --runtime set-property "

	alias jc="journalctl "
	alias jcu="journalctl --user "
	alias ju="journalctl --user "
fi
