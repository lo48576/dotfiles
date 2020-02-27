" Basic {{{1

" Leader key.
let maplocalleader = ";"
let mapleader = ";"

" Disable default {{{1

" Disable `<F1>` (built-in) help.
nnoremap <F1> <nop>
inoremap <F1> <nop>

" Disable `q:` history.
nnoremap q: <nop>
" Disable `Q` visual mode.
nnoremap Q <nop>

" Characters {{{1

inoremap <C-d> <Delete>

"inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
"inoremap <expr> , smartchr#one_of(', ', ',')

" Move {{{1

" Use F3 instead of C-j because input method with SKK captures C-j to switch
" input mode.
imap <F3> <C-j>
nmap <F3> <C-j>

inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" Use incremental search by C-n / C-p in command mode.
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Action {{{1

" Text {{{2

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

nmap J <Plug>(jplus)
vmap J <Plug>(jplus)
"nmap <leader>J <Plug>(jplus-getchar)
"vmap <leader>J <Plug>(jplus-getchar)
nmap <leader>J <Plug>(jplus-input)
vmap <leader>J <Plug>(jplus-input)

map <silent> <C-a> <Plug>(increment-activator-increment)
map <silent> <C-x> <Plug>(increment-activator-decrement)
imap <silent> <C-a> <Plug>(increment-activator-increment)
imap <silent> <C-x> <Plug>(increment-activator-decrement)
" Enable C-a/C-x for multiple lines.
" See <http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html>.
vmap <silent> <C-a> <Plug>(increment-activator-increment)gv
vmap <silent> <C-x> <Plug>(increment-activator-decrement)gv

nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Buffer {{{2

nnoremap <silent> g<C-p> :bp<CR>
nnoremap <silent> g<C-n> :bn<CR>

" Close quickfix buffer by 'q' on the buffer.
autocmd myvimrc FileType qf nnoremap <silent><buffer><nowait> q :quit<CR>

" Mode {{{2

" Toggle paste mode.
" See <http://qiita.com/quwa/items/019250dbca167985fe32>.
" FIXME: Use other key (this conflicts with `SingleCompile` plugin).
imap <F11> <nop>
set pastetoggle=<F11>

" Comment {{{2

let s:nerd_commenter_prefix = '<Leader>c'
call MapKey('nx', s:nerd_commenter_prefix . '<Space>', '<Plug>NERDCommenterToggle')
call MapKey('nx', s:nerd_commenter_prefix . 'c', '<Plug>NERDCommenterComment')
call MapKey('nx', s:nerd_commenter_prefix . 'm', '<Plug>NERDCommenterMinimal')
call MapKey('nx', s:nerd_commenter_prefix . 'n', '<Plug>NERDCommenterNested')
call MapKey('nx', s:nerd_commenter_prefix . 'i', '<Plug>NERDCommenterInvert')
call MapKey('nx', s:nerd_commenter_prefix . 's', '<Plug>NERDCommenterSexy')
call MapKey('nx', s:nerd_commenter_prefix . 'y', '<Plug>NERDCommenterYank')
call MapKey('nx', s:nerd_commenter_prefix . 'A', '<Plug>NERDCommenterAppend')
call MapKey('nx', s:nerd_commenter_prefix . 'a', '<Plug>NERDCommenterAltDelims')
call MapKey('nx', s:nerd_commenter_prefix . 'l', '<Plug>NERDCommenterAlignLeft')
call MapKey('nx', s:nerd_commenter_prefix . 'b', '<Plug>NERDCommenterAlignBoth')
call MapKey('nx', s:nerd_commenter_prefix . 'u', '<Plug>NERDCommenterUncomment')
nmap <silent> <Leader>c$ <Plug>NERDCommenterToEol

" Snippet {{{2

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Navigation {{{1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" Tools {{{1

" NERDTree {{{2
nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" Colorizer {{{2
nmap <leader>ct <Plug>Colorizer

" }}}1

" vim: set foldmethod=marker :
