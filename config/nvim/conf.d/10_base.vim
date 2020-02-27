" Internal {{{1

" Allow unsaved buffers to be hidden from foreground.
set hidden

" Don't save options ("globals") to session file.
set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages

" File {{{1

" Encodings and newlines.
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set ffs=unix,dos,mac

" Enable modeline.
set modeline
set modelines=5

" Language and Locale {{{1

" If the terminal can show Japanese, prefer Japanese help.
if $LANG == "ja_JP.utf8" || $LANG == "ja_JP.UTF-8"
	set helplang=ja,en
else
	set helplang=en
endif

" Use double width for ambiguous width characters.
"if exists('&ambiwidth')
"    set ambiwidth=double
"endif

" UI, Input, and syntax {{{1

" Input {{{2

" Make it available to delete characters by Backspace at any place,
" including beginning of a line.
set backspace=2

" Syntax and smart input {{{2

" Enable doxygen syntax highlighting.
let g:load_doxygen_syntax=1

" Disable automatic break of long line, because I frequently use Japanese.
autocmd myvimrc Filetype text setlocal textwidth=0

" Enable autoindent.
set autoindent

" Prevent autoindent from inserting two tab characters.
set softtabstop=4
set shiftwidth=4

" Set default tab width to 4.
set tabstop=4

" Use spaces for default indent.
"set expandtab

" Too long line may make vim slower, because of work of syntax highlighting.
" Lower limit of column number to be highlighted can make vim faster.
set synmaxcol=1000

" Disable conceal.
set conceallevel=0

" UI {{{2

" Always show 3 or more lines before and after the cursor line.
set scrolloff=3

" Always show line number.
set number

" Enable highlight of cursor line.
set cursorline

" Make whitespace characters visible.
set list

" * tab:tab(capital,subsequent)
" * trail:whitespace(0x20) at the end of line
" * eol:end of line
" * nbsp:0xa0
" * extends: marker for overflowed following characters
" * precedes: marker for overflowed leading characters
"
" These must be halfwidth characters.
" Setting `eol` makes copy-pasting difficult from terminal
" (especially in terminal mode).
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:.

" Disable bell including visual bell
set vb t_vb=

" TODO: Check if the terminal supports true colors.
if has("nvim") && version >= 704 && ($TERM =~# '-256color$' || $TERM =~# ':Tc$')
	set t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	set t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	" From neovim-0.1.5
	set termguicolors
endif

" Disable preview window on completion.
set completeopt-=preview

" }}}1

" vim: set foldmethod=marker :
