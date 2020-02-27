" Functions used by my vimrc.

" Common functions {{{1

" Appends the separator and the first variadic argument if not empty.
function! s:AppendIfNotEmpty(prefix, separator, ...)
	let suffix = get(a:, 1, '')
	if empty(suffix)
		return a:prefix
	else
		return a:prefix . a:separator . suffix
	endif
endfunction

" Returns the `value` if not empty, `default` if empty.
function! s:DefaultIfEmpty(value, default)
	return empty(a:value) ? expand(a:default) : a:value
endfunction

function! s:EnvPathAndSuffix(env, default_path, args)
	let prefix = substitute(s:DefaultIfEmpty(a:env, a:default_path), '/\?$', '', '')
	let suffix = substitute(get(a:args, 0, ''), '^/\?', '', '')
	return s:AppendIfNotEmpty(prefix, '/', suffix)
endfunction

" XDG Base Directory Specification {{{1

function! XdgCacheHome(...)
	return s:EnvPathAndSuffix($XDG_CACHE_HOME, '~/.cache', a:000)
endfunction

function! XdgConfigHome(...)
	return s:EnvPathAndSuffix($XDG_CONFIG_HOME, '~/.config', a:000)
endfunction

function! XdgDataHome(...)
	return s:EnvPathAndSuffix($XDG_DATA_HOME, '~/.local/share', a:000)
endfunction

" Key mapping with variable {{{1

function! s:MapKeyCommandline(mode, lhs, rhs, noremap)
	if a:noremap
		let mapcmd = 'noremap'
	else
		let mapcmd = 'map'
	endif
	return a:mode . l:mapcmd . ' ' . a:lhs . ' ' . a:rhs
endfunction

"function! BulkMapKey(modes, lhs, rhs, noremap)
"    for l:mode in split(a:modes, '\zs')
"        execute MapKeyCommandline(l:mode, a:lhs, a:rhs, a:noremap)
"    endfor
"endfunction

function! MapKey(modes, lhs, rhs)
	for l:mode in split(a:modes, '\zs')
		execute s:MapKeyCommandline(l:mode, a:lhs, a:rhs, v:false)
	endfor
endfunction

"function! NoremapKey(modes, lhs, rhs)
"    for l:mode in split(a:modes, '\zs')
"        execute MapKeyCommandline(l:mode, a:lhs, a:rhs, v:true)
"    endfor
"endfunction

" }}}1

" vim: set foldmethod=marker :
