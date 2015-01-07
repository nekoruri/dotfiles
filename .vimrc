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
Bundle 'tpope/vim-rails'
Bundle 'nanotech/jellybeans.vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'nvie/vim-flake8'

let g:neocomplcache_enable_at_startup = 1

filetype plugin indent on

set modeline

" 前回カーソル位置記憶
" http://masaoo.blogspot.com/2009/08/ubuntu-vim-vimrc.html
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ambiwidth=double
set number
set cursorline

"colorscheme hybrid
colorscheme jellybeans

execute pathogen#infect()
