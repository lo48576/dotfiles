# X.org

# startx
if (( $+commands[startx] )) ; then
	# Prevent executing `startx` from X environment by mistake
	alias startx="[[ -z \${DISPLAY:-} ]] && startx"
fi
