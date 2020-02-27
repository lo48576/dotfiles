function! lo48576#dein#deoplete#hook_add() abort
	let g:deoplete#enable_at_startup = 1

	" Use smartcase.
	let g:deoplete#enable_ignore_case = 1

	" Disable auto complete.
	"let deoplete#disable_auto_complete = 1

	" Define dictionary.
	"let g:deoplete#sources = {}
	"let g:deoplete#sources.cpp = ['buffer', 'tag']

	" Define keyword.
	if !exists('g:deoplete#keyword_patterns')
		let g:deoplete#keyword_patterns = {}
	endif
	let g:deoplete#keyword_patterns.default = '\h\w*'

	function! s:confirm_and_cr() abort
		return deoplete#close_popup() . "\<CR>"
	endfunction

	"function! s:confirm() abort
	"	" Don't insert `<CR>` if the completion popup is visible.
	"	return pumvisible() ? deoplete#close_popup() : "\<CR>"
	"endfunction

	" `<CR>`: Confirm and break line.
	inoremap <silent> <CR> <C-r>=<SID>confirm_and_cr()<CR>

	" <TAB>: completion.
	"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y> deoplete#close_popup()
	inoremap <expr><C-l> deoplete#close_popup()
	"inoremap <expr><C-e>  deoplete#cancel_popup()

	" hard to press 'C-x' on dvorak keyboard, C-u makes completion easier.
	"inoremap <expr><C-u>	pumvisible() ? neocomplete#cancel_popup() : "\<C-x>\<C-u>"
	"inoremap <expr><C-u>	pumvisible() ? deoplete#cancel_popup() : deoplete#manual_complete()
	"inoremap <expr><C-e>	pumvisible() ? deoplete#cancel_popup() : "\<C-e>"
endfunction
