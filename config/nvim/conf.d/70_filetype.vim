" Filetype-specific syntax settings {{{1

" Long long line can make vim quite heavy.
" Disable syntax highlighting on plain text.
function! s:DisableSyntax()
	if &ft =~ 'cmake\|asciidoc\|markdown'
		return
	endif
	set syntax=off
endfunction

augroup PlainTextSyntax
	autocmd!
	autocmd BufEnter,BufNewFile,BufRead *.txt call s:DisableSyntax()
augroup END

" Filetype-specific buffer settings {{{1

autocmd FileType asciidoc setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType haskell setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType ocaml setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal noexpandtab softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType sh setlocal noexpandtab softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType tex setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType yaml setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd Filetype markdown setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
autocmd Filetype text setlocal textwidth=0 noexpandtab
autocmd FileType toml setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4
autocmd FileType xml setlocal softtabstop=2 shiftwidth=2 tabstop=2
autocmd FileType zsh setlocal noexpandtab softtabstop=4 shiftwidth=4 tabstop=4

" }}}1

" vim: set foldmethod=marker :
