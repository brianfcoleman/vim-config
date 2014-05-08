""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package management setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'brianfcoleman/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'wincent/Command-T'
Bundle 'ervandew/ag'
Bundle 'ervandew/supertab'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

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
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:48,results:48'
let g:ctrlp_clear_cache_on_exit = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CommandT setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These values are sufficient for the Androis Open Source Project
let g:CommandTMaxFiles = 524288
let g:CommandTMaxDepth = 20
let g:CommandTMaxCachedDirectories = 4
let g:CommandTFileScanner = 'watchman'
let g:CommandTMatchWindowAtTop = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = 'context'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set hlsearch

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

" Leader keybindings
let mapleader = "\<Space>"
nnoremap <Leader>f :CommandT<CR>
nnoremap <Leader>B :CommandTBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>t :CommandTTag<CR>
nnoremap <Leader>b :CtrlPBufTag<CR>
nnoremap <Leader>q :CtrlPQuickfix<CR>
nnoremap <Leader>d :CtrlPDir<CR>
nnoremap <Leader>j :CommandTJump<CR>
nnoremap <Leader>c :pyf ~/.vim/clang-format.py<CR>

" C++ indentation
" Don't indent within a namespace block
set cino=N-s
