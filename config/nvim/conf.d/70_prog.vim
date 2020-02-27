" Use ripgrep as grep {{{1

if executable('rg')
	set grepprg="rg --vimgrep --no-heading"
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" }}}1

" vim: set foldmethod=marker :
