set nocompatible
syntax on
set modelines=0 "prevent unwanted config"
set number
set encoding=utf-8
set wrap

set ruler
set cursorline
set cursorcolumn

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set copyindent
set expandtab

set hlsearch
set incsearch

set showmatch
set smartcase

set hidden
set ttyfast
set laststatus=2

set showcmd
set background=dark
colorscheme desert

autocmd BufWritePre * :%s/\s\+$//e

