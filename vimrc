""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package management setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tomasr/molokai'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard']
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:ctrlp_extensions =
  \ ['tag', 'buffertag', 'quickfix', 'dir']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Molokai color scheme setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rehash256 = 1
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent
set shiftwidth=2
set softtabstop=2
set expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap : and ;
nnoremap ; :
nnoremap : ;

" Key combinations which exit insert mode
imap jj <Esc>
imap jk <Esc>
imap kk <Esc>
imap kj <Esc>
