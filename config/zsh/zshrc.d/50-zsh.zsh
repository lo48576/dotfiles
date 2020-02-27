# Zsh functions. {{{1
{
	# Path to completions and prompts configuration.
	fpath=(
		${ZDOTDIR}/functions/*(N-/)
		${ZDOTDIR}/functions/lo48576/*(N-/)
		$fpath
		)

	# Autoload functions in the specific directories.
	autoload ${ZDOTDIR}/functions/lo48576/**/*(N.,@:t) \

	# `+X`: load the function immediately.
	autoload +XUz install-zshcomp-cache
}

# CLI. {{{1
{
	# Input and output.
	{
		# Input behavior.
		{
			# Kill the delay after hitting <ESC>.
			KEYTIMEOUT=1
			export KEYTIMEOUT
		}

		# Output behavior.
		{
			# Use beep.
			setopt beep
		}
	}

	# Command line modification.
	{
		# Automatic.
		{
			# Don't remove trailing slash of command line automatically.
			setopt no_autoremoveslash

			# Don't remove some characters after completion.
			# See <https://superuser.com/a/613817>.
			ZLE_REMOVE_SUFFIX_CHARS=""
		}

		# Manual.
		{
			# Enable typo correction.
			setopt correct
		}

		# Interpretation and conversion.
		{
			# Treat `=foo` as `which foo`.
			setopt equals

			# Use (single) `#` as comment start in CLI.
			setopt interactive_comments
		}
	}

	# Execution behavior.
	{
		# Change current directory only with directory path, without `cd`.
		setopt autocd
	}
}

# History. {{{1
{
	# History-related globals.
	{
		# History file.
		HISTFILE=${HISTFILE:-${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/histfile}
		# Create parent directory if the histfile doesn't exist.
		[[ ! -e ${HISTFILE} ]] && mkdir -p -- ${HISTFILE:h}

		# Maximum number of histories to save on memory.
		HISTSIZE=1000000
		# Maximum number of histories to save on file.
		SAVEHIST=1000000000
	}

	# History behavior.
	{
		# Ignore duplicate command-line in history.
		setopt hist_ignore_all_dups
		# Remove old one of duplicate history.
		setopt hist_save_no_dups
		# Ignore duplicate command-line of the previous command-line.
		setopt hist_ignore_dups
		# Never remember command-line which begins with whitespace.
		setopt hist_ignore_space
		# Share command history data.
		setopt share_history
		# Reduce redundant whitespace characters.
		setopt hist_reduce_blanks
		# Never remember history reference command-line.
		setopt hist_no_store
	}

	# History-related key bindings.
	{
		# Incremental search with `^P` and `^N` (like vim).
		autoload history-search-end
		zle -N history-beginning-search-backward-end history-search-end
		zle -N history-beginning-search-forward-end history-search-end
		bindkey '^P' history-beginning-search-backward-end
		bindkey '^N' history-beginning-search-forward-end

	}

	# History-related commands.
	{
		# Disable execution of the last command with `r`.
		# You can do it quite easily with history or incremental search (by `^P`).
		disable r
	}

	# Prevent some commands from being recorded to history.
	zshaddhistory() {
		# Truncate trailing newline.
		local line=${1%%$'\n'}
		# Split command line string into words.
		# `(z)`: Split string into words using shell parsing.
		typeset -a quoted_cmds=( ${(z)line} )
		# `(Q)`: Unquote.
		typeset -a cmds=( ${(Q)${quoted_cmds}} )

		# If contains pipe (`|`), add to history.
		if [[ ${cmds[(ie)|]} -le ${#cmds} ]] ; then
			# Found pipe.
			return 0
		fi
		# Ignore commands with no arguments.
		if [[ ${#cmds} -eq 1 ]] ; then
			case ${quoted_cmds[1][1,1]} in
				'$' | '`')
					# Not simple command, but maybe variable or command expansion.
					return 0
					;;
				*)
					# Simple command with no arguments.
					return 1
					;;
			esac
		fi
		# Ignore some commands.
		typeset -a ignore_cmds=( cd echo ls )
		if [[ ${ignore_cmds[(ie)${cmds[1]}]} -le ${#ignore_cmds} ]] ; then
			# Ignore.
			return 1
		fi
		# Ignore simple subcommands.
		#
		# `g`: alias to `git`.
		typeset -a ignore_single_subcommand=( git g )
		if [[ ( ${ignore_single_subcommand[(ie)${cmds[1]}]} -le ${#ignore_single_subcommand} ) && ( ${#cmds} -le 2 ) ]] ; then
			# Ignore `git` or `git foo`.
			return 1
		fi
		# Ignore some vim commands.
		if [[ ${cmds[1]} == vim ]] ; then
			case ${quoted_cmds[2][1,1]} in
				'~' | '`' | '=' | '$' | '/')
					# Maybe editing special path.
					:
					;;
				*)
					# Maybe editing normal (relative) path.
					return 1
					;;
			esac
		fi
		return 0
	}
}

# Keys. {{{1
{
	# Suppose to use dvorak layout at typo correction.
	setopt dvorak

	# Vim-style key binding.
	bindkey -v

	# Special keys.
	() {
		# For detail, see
		# <https://wiki.archlinuxjp.org/index.php/Zsh#.E3.82.AD.E3.83.BC.E3.83.90.E3.82.A4.E3.83.B3.E3.83.89>.
		typeset -A key
		key[Home]=${terminfo[khome]}
		key[End]=${terminfo[kend]}
		key[Insert]=${terminfo[kich1]}
		key[Delete]=${terminfo[kdch1]}
		key[BackSpace]=${terminfo[kbs]}
		key[Left]=${terminfo[kcub1]}
		key[Down]=${terminfo[kcud1]}
		key[Up]=${terminfo[kcuu1]}
		key[Right]=${terminfo[kcuf1]}

		[[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"      beginning-of-line
		[[ -n ${key[End]}       ]] && bindkey "${key[End]}"       end-of-line
		[[ -n ${key[Insert]}    ]] && bindkey "${key[Insert]}"    overwrite-mode
		[[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"    delete-char
		# NOTE: Some terminal may has wrong sequence as key[BackSpace]...
		[[ -n ${key[BackSpace]} ]] && bindkey "${key[BackSpace]}" backward-delete-char

		[[ -n ${key[Home]}      ]] && bindkey -M vicmd "${key[Home]}"      beginning-of-line
		[[ -n ${key[End]}       ]] && bindkey -M vicmd "${key[End]}"       end-of-line
		[[ -n ${key[Delete]}    ]] && bindkey -M vicmd "${key[Delete]}"    delete-char
		[[ -n ${key[BackSpace]} ]] && bindkey -M vicmd "${key[BackSpace]}" backward-char

		[[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"    backward-char
		[[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"    down-line-or-history
		[[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"      up-line-or-history
		[[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"   forward-char

		[[ -n ${key[Left]}      ]] && bindkey -M vicmd "${key[Left]}"   backward-char
		[[ -n ${key[Down]}      ]] && bindkey -M vicmd "${key[Down]}"   down-line-or-history
		[[ -n ${key[Up]}        ]] && bindkey -M vicmd "${key[Up]}"     up-line-or-history
		[[ -n ${key[Right]}     ]] && bindkey -M vicmd "${key[Right]}"  forward-char
	}

	# `Ctrl-H`.
	bindkey '^H'    backward-delete-char
	# Backspace (in some terminal like tmux).
	bindkey '^?'    backward-delete-char

	# Push command to stack (`Esc-q` at emacs binding)
	# by `Ctrl+7` (in dvorak, `Shift+7` is `^&`.)
	# You can use `Ctrl+-` (`Shift+-` is `^_`.)
	bindkey '^_' push-line
	# Esc, then `q`, to push command to stack.

	bindkey -a 'q' push-line
	# Show help with `Esc H`.
	#bindkey -a 'H' run-help

	#Custom commands
	{
		__cdup() {
			# skip lines to leave old prompt
			local prompt_lines=( ${(@f)PS1} )
			local i
			for i in $prompt_lines ; do echo ; done

			cd ..
			whence precmd >/dev/null && precmd
			for __pre_func in $precmd_functions ; do $__pre_func ; done
			zle reset-prompt
		}
		zle -N __cdup
		# `cd ../` by `Ctrl-6` (in US Keyboard).
		# If you want to type `^^` (`Ctrl-^`), use `Ctrl-V Ctrl-6`.
		bindkey '^^' __cdup
	}
}

# Prompt. {{{1
{
	autoload -Uz promptinit && promptinit

	# Set prmpt
	prompt lo48576_1
}

# Time command behavior. {{{1
() {
	REPORTTIME=30
	local timefmt
	timefmt=(
		'Job: %J'
		'User: %U'
		'Kernel: %S'
		'Elapsed: %E'
		'CPU: %P'
		)
	TIMEFMT=$(print -l $timefmt)
}

# Widgets. {{{1
{
	# Interactive cd. {{{2
	{
		function __interactive-cd() {
			#local selected=$(fd --color=always --type d | sk --ansi --cycle --prompt='cd> ' --query="$LBUFFER")
			local selected=$(fd --type d | sk --cycle --prompt='cd> ' --query="$LBUFFER")
			if [[ -n $selected ]] ; then
				# Add leading whitespace not to save it to history.
				BUFFER=" cd ${(q)selected}"
				zle accept-line
			fi
			zle clear-screen
		}
		if (( $+commands[fd] + $+commands[sk] )) ; then
			zle -N __interactive-cd
			bindkey '^e' __interactive-cd
		fi
	}

	# Select shell history. {{{2
	{
		function __fuzzy-select-histories() {
			local selected=$(history 0 | sk --cycle --prompt='history> ' --query="$LBUFFER" | sed -e 's/\s*[0-9]\+\s*//')
			if [[ -n $selected ]] ; then
				BUFFER="${selected}"
				zle end-of-line
			fi
			zle clear-screen
		}
		if (( $+commands[sk] )) ; then
			zle -N __fuzzy-select-histories
			bindkey '^b' __fuzzy-select-histories
		fi
	}

	# Interactively grep current directory. {{{2
	{
		function __interactive-grep() {
			local selected=$(sk --ansi --tac --cycle --cmd-prompt 'regex> ' --print-cmd --interactive -c 'rg --color=always --line-number "{}"' | head -1)
			if [[ -n $selected ]] ; then
				# Add leading whitespace not to save it to history.
				BUFFER=" rg ${(q)selected}"
				zle accept-line
			fi
			zle clear-screen
		}
		if (( $+commands[rg] + $+commands[sk] )) ; then
			zle -N __interactive-grep
			bindkey '^r' __interactive-grep
		fi
	}

	# Select git reposiotories. {{{2
	{
		# See <http://ubnt-intrepid.hatenablog.com/entry/rhq>.
		function __fuzzy-select-repositories() {
			local selected=$(rhq list | sk --cycle --prompt='REPO> ' --query="$LBUFFER")
			if [[ -n $selected ]] ; then
				# Add leading whitespace not to save it to history.
				BUFFER=" cd ${(q)selected}"
				zle accept-line
			fi
			zle clear-screen
		}
		if (( $+commands[rhq] )) && (( $+commands[sk] )) ; then
			zle -N __fuzzy-select-repositories
			bindkey '^g' __fuzzy-select-repositories
		fi
	}
}

# Completions. {{{1
{
	# Setup. {{{2
	() {
		local zsh_cache_home=${XDG_CACHE_HOME:-${HOME}/.cache}/zsh
		local zsh_compcache_path=${zsh_cache_home}/zcompcache
		local zsh_compdump_path=${zsh_cache_home}/zcompdump
		local zsh_completions_path=${zsh_cache_home}/functions/Completions

		# Completion cache setting.
		zstyle ':completion:*:' cache-path $zsh_compcache_path
		FPATH="${FPATH}:${zsh_completions_path}"

		# Load completion feature.
		autoload -Uz compinit
		# `-C` is for faster boot.
		# -C: skip security check (see <http://zsh.sourceforge.net/Doc/Release/Completion-System.html#index-compinit>).
		# -d: specify dumpfile path (see `man 1 zshcompsys`).
		compinit -C -d $zsh_compdump_path
	}

	# General. {{{2
	{
		zstyle :compinstall filename ${ZDOTDIR:-${HOME}}/.zshrc

		zstyle ':completion:*' verbose yes
		zstyle ':completion:*:descriptions' format '%B%d%b'
		zstyle ':completion:*:messages' format '%d'
		zstyle ':completion:*:warnings' format 'No matches for: %d'
		zstyle ':completion:*' group-name ''

		# Use cache for the completion.
		zstyle ':completion::complete:*' use-cache 1

		# Use compact list when there is lots of items.
		setopt list_packed

		# No beep on completion.
		setopt no_listbeep

		# Allow implicit conversion from lower alphabets to capitals on completion search.
		# (Note that capitals are not converted to lowers.)
		zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

		# Enable completion for long option arguments after `=` (such as `--prefix=/foo/bar/<HERE>`).
		setopt magic_equal_subst
	}

	# Completion for files and directories. {{{2
	if [[ -n ${LS_COLORS:-} ]] ; then
		zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	fi

	# Completion for `kill` and `killall`. {{{2
	{
		# Show completion candidates as process tree.

		# style: pid(yellow) %cpu(cyan) tty(blue) [user(green)] cmd(yellow and red)
		zstyle -e ':completion:*:*:*:*:processes' command \
			'if (( $funcstack[(eI)$_comps[sudo]] )) ; then \
				reply="ps --forest -e -o pid,%cpu,tty,user,cmd" \
			else \
				reply="ps --forest -u $USER -o pid,%cpu,tty,cmd" \
			fi'
		zstyle ':completion:*:*:*:*:processes' list-colors \
			"=(#b) #([0-9]#) #([0-9]#.[0-9]#) #([^ ]#) #([A-Za-z][A-Za-z0-9\-_.]#)# #([\|\\_ ]# )([^ ]#)*=31=33=36=34=32=36=33"
		# Disable sorting because it brakes process tree.
		zstyle ':completion:*:*:*:*:processes' sort false
		# Show completion list (process tree) always
		zstyle ':completion:*:*:kill:*' force-list always

		# For `killall`.
		zstyle -e ':completion:*:processes-names' command \
			'if (( $funcstack[(eI)$_comps[sudo]] )) ; then \
				reply="ps -e -o cmd" \
			else \
				reply="ps -u $USER -o cmd" \
			fi'
	}

	# Completion for `man`. {{{2
	{
		# Separate by sections.
		zstyle ':completion:*:manuals' separate-sections true

		# Change style because the string "manual page, section xx" is hard to see
		# (because of many completion candidates).
		zstyle ':completion:*:*:man:*:manuals.*' format '%F{yellow}%B%U%d%u%b%f'
	}

	# Completion for `sudo`. {{{2
	if [[ -n "$path" ]] ; then
		zstyle ':completion:*:sudo:*' command-path $path
	fi
}

# Completion cache. {{{1
{
	autoload -Uz install-zshcomp-cache

	(( $+commands[rustup] )) && install-zshcomp-cache rustup 'rustup completions zsh'
	(( $+commands[rhq] )) &&  install-zshcomp-cache rhq 'rhq completion zsh'
	(( $+commands[npm] )) &&  install-zshcomp-cache npm 'npm completion'
}

# }}}1

# vim: set foldmethod=marker :
