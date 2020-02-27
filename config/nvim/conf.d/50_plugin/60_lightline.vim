" basic settings
let g:lightline = {}

let g:lightline.mode_map = {
	\ 'n':      'NRM',
	\ 'i':      'INS',
	\ 'R':      'RPL',
	\ 'v':      'VIS',
	\ 'V':      'V-L',
	\ 'c':      'CMD',
	\ "\<C-v>": 'V-B',
	\ 's':      'SEL',
	\ 'S':      'S-L',
	\ "\<C-s>": 'S-B',
	\ 't':      'TRM',
	\ }

" colorscheme
let g:lightline.colorscheme = 'wombat'

" component settings
let g:lightline.component = {}
let g:lightline.component_function = {}
let g:lightline.component_visible_condition = {}

let g:lightline.component.charvaluehex4 = '%04.B'
let g:lightline.component.position = '%04l/%04L:%03v'

"" Use 'readonly_modified' instead.
"call extend(g:lightline.component, {
"    \ 'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
"    \ 'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
"    \})
"call extend(g:lightline.component_visible_condition, {
"    \ 'readonly': '(&filetype!="help"&& &readonly)',
"    \ 'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
"    \ })

let g:lightline.subseparator = {'left': '>', 'right': '<'}


" readonly_modified
call extend(g:lightline.component_function, {
	\ 'readonly_modified': 'MyReadonlyModified'
	\ })

function!	MyReadonlyModified()
	let l:is_help = (&filetype == "help")
	let l:readonly = ""
	if l:is_help
	elseif &readonly
		let l:readonly = "RO"
	endif

	let l:modified = ""
	if l:is_help
	elseif &modified
		" Modified.
		let l:modified = "+"
	elseif &modifiable
	else
		" Not modifiable.
		let l:modified = "-"
	endif

	return	l:readonly . l:modified
endfunction


" fugitive.
call extend(g:lightline.component_function, {
	\ 'fugitive': 'MyFugitive'
	\ })

function!	MyFugitive()
	return	exists('*fugitive#statusline') ? fugitive#statusline() : ''
	"if exists('*fugitive#head')
	"    let _ = fugitive#head()
	"    return strlen(_) ? 'Git:' . _ : ''
	"endif
	"return	''
endfunction


" base settings
let g:lightline.inactive = {}
"let g:lightline.inactive.left = [['filename', 'readonly_modified']]
let g:lightline.inactive.left = [['relativepath', 'readonly_modified']]
let g:lightline.inactive.right = [['position'], ['charvaluehex4'] , ['filetype'], ['fileformat'], ['fugitive']]
"let g:lightline.inactive.right = [['position'], ['charvaluehex4'] , ['filetype'], ['fileformat', 'fugitive']]
let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste']] + g:lightline.inactive.left
let g:lightline.active.right = g:lightline.inactive.right

" Tabline settings.
let g:lightline.tab_component_function = {}

" Current directory.
let g:lightline.component.cd = '%.32(%{fnamemodify(getcwd(), ":~")}%)'
"let g:lightline.component.cd = '%.32(%{pathshorten(fnamemodify(getcwd(), ":~"))}%)'

" tabbuf_nr contains tab number, number of buffers, and modified flag (which
" indicates whether any buffer of the tab is modified, or nothing is modified).
let g:lightline.tab_component_function.tabbuf_nr = 'TabBufNr'
function!	TabBufNr(n)
	let bufnr_list = tabpagebuflist(a:n)
	let bufnr = len(bufnr_list)
	if bufnr <= 1
		let bufnr_str = ''
	else
		let bufnr_str = '>' . bufnr
	endif
	let modified_any = len(filter(copy(bufnr_list),'getbufvar(v:val,"&modified")')) ? '+' : ''
	"return	lightline#concatenate([a:n, bufnr_str], 0)
	"return	a:n . bufnr_str . lightline#tab#modified(a:n)
	return	a:n . bufnr_str . modified_any
endfunction

let g:lightline.tab_component_function.path_shorten = 'BufPathShorten'
function!	BufPathShorten(n)
	let bufnr_list = tabpagebuflist(a:n)
	let curbufnr = bufnr_list[tabpagewinnr(a:n)-1]
	return	pathshorten(bufname(curbufnr))
endfunction

let g:lightline.tabline_separator = {'left': '|', 'right': '|'}
let g:lightline.tabline_subseparator = {'left': '>', 'right': '<'}
let g:lightline.tab = {}
let g:lightline.tabline = {}
let g:lightline.tabline.left = [['tabs']]
let g:lightline.tabline.right = [['cd']]
let g:lightline.tab.inactive = ['tabbuf_nr', 'path_shorten']
"let g:lightline.tab.inactive = ['prefix', 'filename']
let g:lightline.tab.active = g:lightline.tab.inactive
