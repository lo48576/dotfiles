__zshrc_host-conf() {
	# $1: name
	# $2: target dir
	dir-alias() {
	    [[ -d $2 ]] && hash -d $1=$2 || true
	}

	# Config directories.
	dir-alias homebin ${XDG_BIN_HOME:-${XDG_DATA_HOME:-${HOME}/.local/share}/../bin}
	dir-alias mybin ${XDG_BIN_HOME:-${XDG_DATA_HOME:-${HOME}/.local/share}/../bin}
	dir-alias conf ${XDG_CONFIG_HOME:-${HOME}/.config}
	dir-alias zsh ${ZDOTDIR:-${HOME}}
	if [[ -n $current_dir ]] ; then
		dir-alias zshlocal $current_dir
	fi
	dir-alias nvim ~conf/nvim
	dir-alias dot ~/.local/dotfiles

	# Temporary directory.
	dir-alias tmp ~/tmp
	dir-alias temp ~tmp

	# Development.
	dir-alias works ~/works
	dir-alias coldev ~works/public/collabo
	dir-alias contrib ~works/public/contrib
	dir-alias cusdev ~works/public/custom
	dir-alias mydev ~works/public/origin
	dir-alias dev-early ~works/public/origin/_early-stage
	dir-alias docs ~works/public/origin/docs
	dir-alias web ~works/public/origin/docs/website
	dir-alias play ~works/public/playground
	dir-alias play-int ~works/internal/playground
	dir-alias play-secret ~works/secret/playground
	dir-alias dev-titech ~works/secret/origin/titech

	dir-alias opty ~mydev/opaque_typedef
	dir-alias fbxcel ~mydev/fbxcel/fbxcel
	dir-alias fbxdom ~mydev/fbxcel/fbxcel-dom
	dir-alias rpub ~mydev/rustivitypub
	dir-alias cusl ~mydev/custom-slice
	dir-alias jld ~mydev/json-ld
	#dir-alias jtest ~mydev/json-ld/json-ld-tests
	dir-alias rskk ~mydev/rskk
	dir-alias paradocs ~mydev/paradocs
	dir-alias xmlop ~mydev/xmlop
	dir-alias xpath ~mydev/xmlop-xpath

	dir-alias blog ~docs/website/blog.cardina1.red
	dir-alias www ~docs/website/www.cardina1.red

	# Titech.
	dir-alias titech ~works/secret/titech
	dir-alias lab ~works/secret/titech/nishizakilab
	dir-alias master-thesis ~works/secret/titech/nishizakilab/master-thesis

	# Local mounts.
	dir-alias sysvol /mnt/sysvol
	dir-alias crow /mnt/crow

	dir-alias mnt-udisks /run/media/${USER}
	dir-alias mnt /run/user/${UID}/media

	unfunction dir-alias
}

if [[ ${HOST} == ichika ]] ; then
	__zshrc_host-conf
fi
unfunction __zshrc_host-conf
