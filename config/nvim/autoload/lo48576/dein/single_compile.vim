function! lo48576#dein#single_compile#hook_post_source() abort
	" Graphviz.
	if executable('dot')
		"call SingleCompile#SetCompilerTemplate('dot', 'dot', 'dot for png', 'dot', '-Tpng -o $(FILE_TITLE)$.png', 'xdg-open $(FILE_TITLE)$.png')
		call SingleCompile#SetCompilerTemplate('dot', 'dot', 'dot for png', 'dot', '-Tpng -o $(FILE_TITLE)$.png', '')
		call SingleCompile#SetOutfile('dot', 'dot', '$(FILE_TITLE)$.png')
		call SingleCompile#ChooseCompiler('dot', 'dot')
	endif

	" Sass.
	if executable('sass')
		call SingleCompile#SetCompilerTemplate('sass', 'sass', 'Sass', 'sass', '--no-cache $(FILE_NAME)$ $(FILE_TITLE)$.css', '')
		call SingleCompile#SetOutfile('sass', 'sass', '$(FILE_TITLE)$.css')
		call SingleCompile#ChooseCompiler('sass', 'sass')
	endif

	" SCSS.
	if executable('scss')
		call SingleCompile#SetCompilerTemplate('scss', 'scss', 'Scss', 'sass', '--scss --no-cache $(FILE_NAME)$ $(FILE_TITLE)$.css', '')
		call SingleCompile#SetOutfile('scss', 'scss', '$(FILE_TITLE)$.css')
		call SingleCompile#ChooseCompiler('scss', 'scss')
	endif

	" AsciiDoc.
	if executable('asciidoctor')
		"call SingleCompile#SetCompilerTemplate('asciidoc', 'asciidoctor', 'Asciidoctor html5', 'asciidoctor', '-b html5 $(FILE_NAME)$ -o $(FILE_TITLE)$.html', 'xdg-open $(FILE_TITLE)$.html')
		call SingleCompile#SetCompilerTemplate('asciidoc', 'asciidoctor', 'Asciidoctor html5', 'asciidoctor', '-b html5 $(FILE_NAME)$ -o $(FILE_TITLE)$.html', '')
		call SingleCompile#SetOutfile('asciidoc', 'asciidoctor', '$(FILE_TITLE)$.html')
		call SingleCompile#ChooseCompiler('asciidoc', 'asciidoctor')
	endif
endfunction
