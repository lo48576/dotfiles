" Settings for neovim-gtk.
" See <https://github.com/daa84/neovim-gtk/wiki/Configuration>.

let s:default_gui_font_size = 12
let s:font_size_unit = 2

function! GetGuiFontSize()
	return s:gui_font_size
endfunction

function! s:ApplyGuiFontSize()
	call rpcnotify(1, 'Gui', 'Font', 'Fira Code ' . GetGuiFontSize())
endfunction

function! IncreaseGuiFontSize()
	let s:gui_font_size += s:font_size_unit
	call s:ApplyGuiFontSize()
endfunction

function! DecreaseGuiFontSize()
	let s:gui_font_size -= s:font_size_unit
	call s:ApplyGuiFontSize()
endfunction

if exists('g:GtkGuiLoaded')
	if !exists('s:gui_font_size')
		let s:gui_font_size = s:default_gui_font_size
	endif
	call s:ApplyGuiFontSize()

	map <silent> <C-=> :<C-u>call IncreaseGuiFontSize()<CR>
	imap <silent> <C-=> :<C-u>call IncreaseGuiFontSize()<CR>
	map <silent> <C-+> :<C-u>call IncreaseGuiFontSize()<CR>
	imap <silent> <C-+> :<C-u>call IncreaseGuiFontSize()<CR>
	map <silent> <C-ScrollWheelUp> :<C-u>call IncreaseGuiFontSize()<CR>
	imap <silent> <C-ScrollWheelUp> :<C-u>call IncreaseGuiFontSize()<CR>
	map <silent> <C--> :<C-u>call DecreaseGuiFontSize()<CR>
	imap <silent> <C--> :<C-u>call DecreaseGuiFontSize()<CR>
	map <silent> <C-ScrollWheelDown> :<C-u>call DecreaseGuiFontSize()<CR>
	imap <silent> <C-ScrollWheelDown> :<C-u>call DecreaseGuiFontSize()<CR>
endif
