" See <https://qiita.com/kawaz/items/ee725f6214f91337b42b>.

let s:dein_dir = XdgCacheHome('dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
	call system('git clone "https://github.com/Shougo/dein.vim" ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir . "," . &runtimepath

let s:toml_dir = fnamemodify(expand('<sfile>'), ':h')
let s:toml_file = s:toml_dir . '/dein.toml'
let s:toml_file_ft = s:toml_dir . '/dein_ft.toml'
let s:toml_file_lazy = s:toml_dir . '/dein_lazy.toml'
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	call dein#load_toml(s:toml_file)
	call dein#load_toml(s:toml_file_ft, {'lazy': 1})
	call dein#load_toml(s:toml_file_lazy, {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
	call dein#install()
endif

if has('vim_starting')
	call dein#call_hook('source')
	call dein#call_hook('post_source')
	filetype plugin indent on
	syntax enable
endif
