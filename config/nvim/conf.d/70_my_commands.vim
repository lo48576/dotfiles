" Change working directory to the directory of the current file. {{{1
function! s:Cdfile()
	cd %:p:h
endfunction
command! -bar -bang -nargs=0 Cdfile call s:Cdfile()

" Highlight a column in csv text. {{{1
" See <http://vim.wikia.com/wiki/Working_with_CSV_files>.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{' . n .'}\zs[^,]*/'
    execute 'normal! 0' . n . 'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" Returns RFC 3339 & ISO 8601 compliant datetime string. {{{1
function! Datetime()
    let l:src = strftime("%FT%T%z")
    return substitute(l:src, '\(\%(+\|-\)\d\{2\}\)\(\d\{2\}\)$', '\1:\2', '')
endfunction
" ISO 8601 & RFC 3339 (yyyy-mm-ddThh:mm:ss+hh:mm)
" Note that ISO 8601 accepts `+hhmm`-style timezone, but RFC 3339 doesn't.
" See <http://vim.wikia.com/wiki/Insert_current_date_or_time>.
nnoremap <F5> "=Datetime()<CR>P
inoremap <F5> <C-R>=Datetime()<CR>

" Returns RFC 3339 & ISO 8601 compliant date string. {{{1
function! Date()
    return strftime("%F")
endfunction

" Save file and create directory if necessary. {{{1
function! s:SaveAndWrite()
	" FIXME: Don't mkdir normally on path with special prefix, such as `sudo:`.
	!mkdir -p %:p:h
	w
endfunction
command! -bar -nargs=0 W call s:SaveAndWrite()

" `Quit` (or `Q`) to quit vim. {{{1
function! s:Quit()
	quit
endfunction
command! -bar -nargs=0 Quit call s:Quit()

" Returns newly generated UUID. {{{1
function! Uuid()
	return substitute(system("uuidgen"), '\n$', '', '')
endfunction

" }}}1

" vim: set foldmethod=marker :
