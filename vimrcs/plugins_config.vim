"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important: 
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/.vim_runtime/sources_forked/{}')
call pathogen#infect('~/.vim_runtime/sources_non_forked/{}')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
if has("win16") || has("win32")
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim_runtime/temp_dirs/'
endif


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline config (force color)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme="luna"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_python_checkers=['pyflakes']


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TComment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call tcomment#DefineType('haxe',                '// %s'    )
call tcomment#DefineType('haxe_inline',         g:tcommentInlineC  )
call tcomment#DefineType('haxe_block',          g:tcommentBlockC   )

map <C-E> :TComment<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vaxe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" better completion shortcut
inoremap <C-Space> <C-X><C-O>
inoremap <Nul> <C-X><C-O>

function GetParent(item)
	let parent = substitute(a:item, '[\/][^\/]\+[\/:]\?$', '', '')
	if parent == '' || parent !~ '[\/]'
		let parent .= '/'
	en
	retu parent
endf

function GetHxml(dir,depth)
	let depth = a:depth + 1
	let hxmls = split(glob(a:dir . "/*.hxml"), "\n")
	if len(hxmls) > 0
		let base_hxml = vaxe#util#InputList("Select Hxml", hxmls)
		let g:vaxe_hxml = base_hxml
		echo "found " . base_hxml
		call vaxe#SetCompiler()
		retu g:vaxe_hxml
	else
		let parent = GetParent(a:dir)
		if parent != a:dir && a:depth < 10
			retu GetHxml(parent,depth)
		endif
		echo "not found hxml"
	endif
endfunction

map <leader>i <ESC>:call vaxe#ImportClass()<CR>
map <leader>hc <ESC>:call vaxe#Ctags()<CR>
map <leader>hh <ESC>:call GetHxml(getcwd(),0)<CR>
map <leader>ho <ESC>:call vaxe#OpenHxml()<CR>

autocmd BufEnter *.hx :call GetHxml(getcwd(),0)

if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.haxe = '\v([\]''"]|\w)(\.|\()'

set autowrite

" use completion cache server
let g:vaxe_cache_server = 1

" use absolute paths for hxmls
let g:vaxe_trace_absolute_path = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F6> <ESC>:Goyo<CR>
