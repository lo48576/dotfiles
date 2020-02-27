" Highlight trailing spaces {{{1

" See <http://d.hatena.ne.jp/mickey24/20120808/vim_highlight_trailing_spaces>.
augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" }}}1

" vim: set foldmethod=marker :
