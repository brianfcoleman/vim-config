""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package management setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'brianfcoleman/ctrlp.vim'
Bundle 'brianfcoleman/snipmate.vim'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=256
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .']
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:ctrlp_extensions =
  \ ['tag', 'buffertag', 'quickfix', 'dir']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:32,results:32'
let g:ctrlp_clear_cache_on_exit = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent
set shiftwidth=2
set softtabstop=2
set expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Strip trailing whitespace when writing a buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :silent! %s/\s\+$//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not create swapfiles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap : and ;
nnoremap ; :
nnoremap : ;

" Exit insert mode
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>
inoremap kj <Esc>

" CtrlP keybindings
let mapleader = "\<Space>"
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>B :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>b :CtrlPBufTag<CR>
nnoremap <Leader>q :CtrlPQuickfix<CR>
nnoremap <Leader>d :CtrlPDir<CR>

" C++ indentation
" Don't indent within a namespace block
set cino=N-s
