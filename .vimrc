set fileencodings=utf-8,euc-jp,ucs-2le,ucs-2,cp932
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'rails.vim'

filetype plugin indent on

set modeline

" 前回カーソル位置記憶
" http://masaoo.blogspot.com/2009/08/ubuntu-vim-vimrc.html
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


