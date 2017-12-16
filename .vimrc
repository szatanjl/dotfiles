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
