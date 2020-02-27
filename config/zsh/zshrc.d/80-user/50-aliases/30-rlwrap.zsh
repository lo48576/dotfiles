# rlwrap
if (( $+commands[rlwrap] )) ; then
	(( $+commands[ocaml] )) && alias ocaml="rlwrap ocaml"
	(( $+commands[gosh] )) && alias gosh="rlwrap gosh"
	true
fi
