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
