" PREAMBLE {{{
set nocompatible
filetype on
syntax on
augroup VIMRC
	autocmd!
augroup END
" }}}
" BACKUP {{{
set nobackup writebackup backupdir=~/.vim/backup// backupext=~ backupskip=/tmp/*
set noswapfile directory=~/.vim/swap// updatecount=200 updatetime=4000
set undofile undodir=~/.vim/undo// undolevels=1000 undoreload=10000
set viewdir=~/.vim/view// viewoptions=cursor,folds,options
set sessionoptions=blank,buffers,curdir,folds,options,tabpages,winsize
set viminfo='100,s0,h,n~/.vim/info history=100
" }}}
" HIGHLIGHT {{{ TODO light bg / 16 colors
" s:hi() {{{
function! s:hi(name, style, fg, bg) abort
	function! s:gui(color) abort
		if a:color >= 232 && a:color <= 255
			let r = (a:color - 232) * 10 + 8
			let g = (a:color - 232) * 10 + 8
			let b = (a:color - 232) * 10 + 8
		elseif a:color >= 16
			let r = ((a:color - 16) / 6 / 6) * 40
			let g = ((a:color - 16) / 6 % 6) * 40
			let b = ((a:color - 16) % 6) * 40
			let r += r > 0 ? 55 : 0
			let g += g > 0 ? 55 : 0
			let b += b > 0 ? 55 : 0
		else
			return a:color
		endif
		return printf('#%02X%02X%02X', r, g, b)
	endfunction
	execute 'highlight '.a:name .
	\       ' cterm='.a:style.' gui='.a:style .
	\       ' ctermfg='.a:fg.' guifg='.s:gui(a:fg) .
	\       ' ctermbg='.a:bg.' guibg='.s:gui(a:bg)
endfunction
" }}}
" s:globalmatchadd() {{{
autocmd VIMRC VimEnter,WinEnter * let w:VIMRC_ma = exists('w:VIMRC_ma')
function! s:globalmatchadd(group, pattern) abort
	execute 'autocmd VIMRC VimEnter,WinEnter * if !w:VIMRC_ma | ' .
	\       "call matchadd('".a:group."', '".a:pattern."') | endif"
endfunction
" }}}
" colors {{{
let s:bg_borders = 233
let s:bg_main = 234
let s:bg_alt = 235
let s:bg_hl = 236
let s:bg_sel = 240
let s:fg_borders = 244
let s:fg_main = 252
let s:fg_alt = 240
" }}}
" highlight {{{
highlight clear
" cmd {{{
call s:hi('Title', 'bold', s:fg_main, 'NONE')
call s:hi('MoreMsg', 'bold', s:fg_main, 'NONE')

call s:hi('Directory', 'NONE', s:fg_main, 'NONE')
call s:hi('ModeMsg', 'NONE', s:fg_main, 'NONE')
call s:hi('Question', 'NONE', s:fg_main, 'NONE')
call s:hi('WarningMsg', 'NONE', s:fg_main, 'NONE')
call s:hi('ErrorMsg', 'NONE', s:fg_main, 124)

call s:hi('WildMenu', 'bold', 226, s:bg_borders)
" }}}
" statusline {{{
call s:hi('StatusLineNormal1', 'bold', s:fg_main, 239)
call s:hi('StatusLineInsert1', 'bold', s:fg_main, 94)
call s:hi('StatusLineReplace1', 'bold', s:fg_main, 124)
call s:hi('StatusLineVisual1', 'bold', s:fg_main, 27)
call s:hi('StatusLineNormal2', 'NONE', s:fg_main, 236)
call s:hi('StatusLineInsert2', 'NONE', s:fg_main, 236)
call s:hi('StatusLineReplace2', 'NONE', s:fg_main, 236)
call s:hi('StatusLineVisual2', 'NONE', s:fg_main, 236)
call s:hi('StatusLine', 'NONE', s:fg_main, s:bg_borders)
call s:hi('StatusLineNC', 'NONE', s:fg_borders, s:bg_borders)
" }}}
" tabline {{{
call s:hi('TabLineSel', 'NONE', s:fg_main, 239)
call s:hi('TabLine', 'NONE', s:fg_borders, s:bg_borders)
call s:hi('TabLineFill', 'NONE', s:fg_borders, s:bg_borders)
" }}}
" borders {{{
call s:hi('VertSplit', 'NONE', s:fg_borders, s:bg_borders)
call s:hi('FoldColumn', 'NONE', s:fg_borders, s:bg_borders)
call s:hi('SignColumn', 'NONE', s:fg_borders, s:bg_borders)
call s:hi('LineNr', 'NONE', s:fg_borders, s:bg_borders)
" }}}
" cursor {{{
call s:hi('CursorLineNr', 'NONE', s:fg_main, s:bg_hl)
call s:hi('CursorLine', 'NONE', 'NONE', s:bg_hl)
call s:hi('CursorColumn', 'NONE', 'NONE', s:bg_hl)
call s:hi('Cursor', 'reverse', 'NONE', 'NONE')
" }}}
" text {{{
call s:hi('NonText', 'NONE', s:fg_alt, 'NONE')
call s:hi('SpecialKey', 'NONE', s:fg_alt, 'NONE')

call s:hi('Normal', 'NONE', s:fg_main, 'NONE')  " s:bg_main
call s:hi('ColorColumn', 'NONE', 'NONE', s:bg_alt)
call s:hi('Visual', 'NONE', 'NONE', s:bg_sel)
call s:hi('VisualNOS', 'NONE', 'NONE', s:bg_sel)

call s:hi('Folded', 'NONE', 248, 238)

call s:globalmatchadd('SpecialKey', '\s')
" }}}
" search {{{ TODO more searches?
call s:hi('MatchParen', 'NONE', 'NONE', 36)

call s:hi('IncSearch', 'NONE', 16, 226)
call s:hi('Search', 'NONE', 16, 226)

call s:hi('Search1', 'NONE', 16, 214)
call s:hi('Search2', 'NONE', 16, 201)
call s:hi('Search3', 'NONE', 16, 51)
call s:hi('Search4', 'NONE', 16, 21)
" }}}
" diff {{{
call s:hi('DiffAdd', 'NONE', 'NONE', 22)
call s:hi('DiffDelete', 'NONE', s:fg_alt, 52)
call s:hi('DiffChange', 'NONE', s:fg_alt, s:bg_alt)
call s:hi('DiffText', 'NONE', 'NONE', s:bg_alt)
" }}}
" spellcheck {{{
call s:hi('SpellBad', 'undercurl', 196, 'NONE')
call s:hi('SpellCap', 'undercurl', 196, 'NONE')
call s:hi('SpellLocal', 'undercurl', 196, 'NONE')
call s:hi('SpellRare', 'NONE', 'NONE', 'NONE')
" }}}
" popup menu {{{
call s:hi('Pmenu', 'NONE', s:fg_alt, s:bg_hl)
call s:hi('PmenuSel', 'NONE', s:fg_main, s:bg_sel)
call s:hi('PmenuSbar', 'NONE', 'NONE', s:bg_hl)
call s:hi('PmenuThumb', 'NONE', 'NONE', 16)
" }}}
" syntax {{{ TODO
" }}}
" wrong whitespace {{{
call s:hi('WrongWhitespace', 'NONE', s:fg_alt, 52)

call s:globalmatchadd('WrongWhitespace', '\(^\t*\)\@<!\t')
call s:globalmatchadd('WrongWhitespace', '\(^\s*\)\@<= \+\t')
call s:globalmatchadd('WrongWhitespace', '[.!?]\@<!\s\+$')
" Dont highlight trailing whitespace on current line in insert mode {{{
augroup VIMRC_ww
	autocmd!
augroup END

autocmd VIMRC InsertEnter *
\	execute 'match SpecialKey /\%'.line('.').'l\s\+$/' |
\	autocmd VIMRC_ww WinEnter,CursorMoved,CursorMovedI *
\		execute 'match SpecialKey /\%'.line('.').'l\s\+$/'

autocmd VIMRC WinLeave * match none
autocmd VIMRC InsertLeave * match none | autocmd! VIMRC_ww
" }}}
" }}}
" }}}
" }}}
" CMD {{{
set noshowmode noshowcmd
set cmdheight=1 cmdwinheight=6
set wildmenu wildmode=longest:full,full wildignorecase
set wildignore= suffixes=
" }}}
" LINES {{{
" s:fname() {{{
function! s:fname(short, ...) abort
	let bufnr = a:0 > 0 ? a:1 : bufnr('%')
	if empty(expand('#'.bufnr))
		return '[No Name]'
	elseif !a:short
		return expand('#'.bufnr)
	endif
	let fname = ''
	let expr = '#'.bufnr
	while expand(expr) != expand(expr.':h')
		let tail = expand(expr.':t')
		let sep = expand(expr)[:-(len(tail) + 1)][-1:]
		let fname = sep . tail[0:(tail[0] == '.')] . fname
		let expr .= ':h'
	endwhile
	return expand(expr)[0:-2] . fname
endfunction
" }}}
" Statusline() {{{
function! StlMode() abort
	return get({
	\	'v': 'VISUAL', 'V': 'V-LINE', "\<c-v>": 'V-BLCK',
	\	's': 'SELECT', 'S': 'S-LINE', "\<c-s>": 'S-BLCK',
	\	'i': 'INSERT', 'R': 'RPLACE', 'Rv': 'R-VIRT'
	\ }, mode(1), 'NORMAL')
endfunction

function! StlFname() abort
	return s:fname(get(b:, 'stl_fname_short')) .
	\      (&mod ? ' [+]' : &ro || !&ma ? ' [-]' : '')
endfunction

function! StlFinfo() abort
	let ff = get({'dos': 'CRLF', 'unix': 'LF', 'mac': 'CR'}, &ff)
	let sw = (!&sta && &sts > 0) ? &sts :
	\        ((&sta || &sts < 0) && &sw) ? &sw : &ts
	let fi = (&et ? 'spc' : sw != &ts ? 'mix' : 'tab').':'.sw .
	\        (!&et && sw != &ts ? '/'.&ts : '')
	return &fenc.'['.ff.'] '.fi
endfunction

function! StlRuler() abort
	return repeat(' ', strwidth(line('$')) - strwidth(line('.'))) .
	\      line('.').'/'.line('$').' ' .
	\      repeat(' ', 3 - strwidth(virtcol('.'))).virtcol('.')
endfunction

function! Statusline() abort
	let s:mode = get({
	\	'v': 'Visual', 'V': 'Visual', "\<c-v>": 'Visual',
	\	's': 'Visual', 'S': 'Visual', "\<c-s>": 'Visual',
	\	'i': 'Insert', 'R': 'Replace', 'Rv': 'Replace'
	\ }, mode(1), 'Normal')
	function! s:module(hi, val, ...) abort
		let ncval = a:0 > 0 ? a:1 : a:val
		return '%#StatusLine'.s:mode.a:hi.'#' .
		\      '%{winnr() != '.winnr().' ? "" : ('.a:val.')}' .
		\      '%*%{winnr() == '.winnr().' ? "" : ('.ncval.')}'
	endfunction
	return s:module(1, '"  ".StlMode()." "', '"  ------ "') .
	\      '%<' . s:module(3, '"  ".StlFname()') .
	\      '%=' . s:module(3, '"  ".&ft." "') .
	\      s:module(2, '"  ".StlFinfo()." "') .
	\      s:module(1, '"  ".StlRuler()." "')
endfunction
" }}}
" Tabline() {{{
function! Tabline() abort
	let bufnr = buflisted(bufnr('%')) ? bufnr('%') : bufnr('#')
	let fname = s:fname(get(g:, 'tal_fname_short'), bufnr)
	let bufs = '%#TabLineSel# '.fname.' %#TabLine#'
	let size = &columns - 16 - strwidth(fname)
	let lbuf = bufnr
	let rbuf = bufnr
	let lbarr = ''
	let rbarr = ''
	while lbuf > 0 || rbuf <= bufnr('$')
		let lbuf -= 1
		while lbuf > 0 && !buflisted(lbuf)
			let lbuf -= 1
		endwhile
		let fname = s:fname(get(g:, 'tal_fname_short'), lbuf)
		if lbuf > 0
			if strwidth(fname) + 3 <= size
				let bufs = ' '.fname.' |' . bufs
				let size -= strwidth(fname) + 3
			else
				let lbuf = 0
				let lbarr = '<'
			endif
		endif
		let rbuf += 1
		while rbuf <= bufnr('$') && !buflisted(rbuf)
			let rbuf += 1
		endwhile
		let fname = s:fname(get(g:, 'tal_fname_short'), rbuf)
		if rbuf <= bufnr('$')
			if strwidth(fname) + 3 <= size
				let bufs .= '| '.fname.' '
				let size -= strwidth(fname) + 3
			else
				let rbuf = bufnr('$')
				let rbarr = '>'
			endif
		endif
	endwhile

	let tabs = '%#TabLineSel# '.tabpagenr().' %#TabLine#'
	let size = 7 - strwidth(tabpagenr())
	let ltab = tabpagenr()
	let rtab = tabpagenr()
	let ltarr = ''
	let rtarr = ''
	while ltab > 0 || rtab <= tabpagenr('$')
		let ltab -= 1
		if ltab > 0
			if strwidth(ltab) + 2 <= size
				let tabs = ' '.ltab.' ' . tabs
				let size -= strwidth(ltab) + 2
			else
				let ltab = 0
				let ltarr = '<'
			endif
		endif
		let rtab += 1
		if rtab <= tabpagenr('$')
			if strwidth(rtab) + 2 <= size
				let tabs .= ' '.rtab.' '
				let size -= strwidth(rtab) + 2
			else
				let rtab = tabpagenr('$')
				let rtarr = '>'
			endif
		endif
	endwhile

	return '%#TabLine#'.lbarr.bufs.rbarr .
	\      '%#TabLineFill#%=' .
	\      '%#TabLine#'.ltarr.tabs.rtarr
endfunction
" }}}
set laststatus=2 statusline=%!Statusline()
set showtabline=2 tabline=%!Tabline()
" }}}
" BUFFERS {{{
set noautochdir nomodeline noautoread
set write nowriteany noautowrite noautowriteall confirm hidden
" }}}
" WINDOWS {{{
set winheight=24 winminheight=1 winwidth=96 winminwidth=1
set splitbelow splitright
" }}}
" MOVEMENT {{{
set scrolljump=1 scrolloff=0 sidescroll=1 sidescrolloff=1
set whichwrap=<,>,[,] backspace=indent,eol,start virtualedit=block
set selection=inclusive
" }}}
" SEARCH {{{
set noshowmatch matchtime=5 matchpairs=(:),{:},[:]
set ignorecase smartcase wrapscan noincsearch hlsearch gdefault
set grepprg= grepformat= " TODO
" }}}
" TEXT {{{
set number norelativenumber numberwidth=5
set cursorline nocursorcolumn colorcolumn=73,81
set listchars=tab:\|\ ,trail:~,precedes:<,extends:> list
set wrap showbreak=~ breakat=\ \	 linebreak
set breakindent breakindentopt=min:40,shift:4,sbr
set display=lastline
" }}}
" FOLD {{{
" Foldtext() {{{
function! Foldtext() abort
	for i in range(v:foldstart, v:foldend)
		let line = substitute(getline(i), '^\s*', '', '')
		let line = substitute(line, '\s*$', '', '')
		if match(line, '[0-9A-Za-z{([]') != -1 ||
		\  strchars(line) != strlen(line)
			return repeat(' ', indent(i)) . line . ' ... '
		endif
	endfor
	let line = substitute(getline(v:foldstart), '^\s*', '', '')
	let line = substitute(line, '\s*$', '', '')
	return repeat(' ', indent(v:foldstart)) . line . ' ... '
endfunction
" }}}
set foldenable foldtext=Foldtext() foldcolumn=0
set foldopen=insert,mark,quickfix,tag,undo foldclose=
set foldmethod=marker foldlevelstart=0 foldminlines=1
set foldmarker={{{,}}} foldignore= foldexpr=
" Dont screw up folds when typing in insert mode {{{
augroup VIMRC_fm
	autocmd!
augroup END

autocmd VIMRC InsertEnter *
\	if !exists('w:VIMRC_lfm') |
\		let w:VIMRC_lfm=&foldmethod |
\		set foldmethod=manual |
\	endif |
\	autocmd VIMRC_fm WinEnter *
\		if !exists('w:VIMRC_lfm') |
\			let w:VIMRC_lfm=&foldmethod |
\			set foldmethod=manual |
\		endif

autocmd VIMRC WinLeave *
\	if exists('w:VIMRC_lfm') |
\		let &foldmethod = w:VIMRC_lfm |
\		unlet w:VIMRC_lfm |
\	endif
autocmd VIMRC InsertLeave *
\	if exists('w:VIMRC_lfm') |
\		let &foldmethod = w:VIMRC_lfm |
\		unlet w:VIMRC_lfm |
\	endif |
\	autocmd! VIMRC_fm
" }}}
" }}}
" INDENT {{{
set shiftwidth=0 noexpandtab softtabstop=0 tabstop=8 smarttab
set autoindent copyindent preserveindent noshiftround
set equalprg= indentkeys= indentexpr= " TODO
" }}}
" FORMATTING {{{ formatoptions(wa)
set textwidth=72 formatoptions=roqn1j joinspaces cpoptions+=J
set formatlistpat=^\\s*\\([*+-]\\\|\\w\\+[.:)]\\)\\s*
set formatprg= formatexpr= " TODO
" }}}
" DIFF {{{ diffopt(iwhite)
set diffopt=filler,context:3,vertical,foldcolumn:0 diffexpr=
set scrollopt=ver,hor,jump
if &diff
	set nocursorline
endif
" }}}
