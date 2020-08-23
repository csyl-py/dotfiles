call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'dyng/ctrlsf.vim'
Plug 'lervag/vimtex'
Plug 'PotatoesMaster/i3-vim-syntax'
call plug#end()

let fortran_free_source=1
set runtimepath+=~/path/to/deoplete.nvim/
" usando deoplete (autocompletion)
let g:deoplete#enable_at_startup = 1
  set tabstop=4
  set shiftwidth=4
  set expandtab
  set relativenumber
  au BufNewFile,BufRead *.py
    \ set tabstop=4
"    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let mapleader = " "

" DEOCOMPLETE
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

syntax enable
filetype plugin on
set background=dark
let g:solarized_contrast = "high"
"let g:solarized_termcolors = "256"
colorscheme solarized

" Numero absoluto en linea actual
set nu rnu
