""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package management setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'brianfcoleman/ctrlp.vim'
Bundle 'tomasr/molokai'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sickill/vim-monokai'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=256
set background=dark
colorscheme Monokai

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files']
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
set ignorecase smartcase

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
" Key mapping setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap : and ;
nnoremap ; :
nnoremap : ;

" C-like syntax statemant completion
iab kk <Esc>A;<Esc>

" Remove the character underneath the cursor if it is a space
func EatWhiteSpace()
  let c = nr2char(getchar(0))
  return (c =~ '\s') ? '' : c
endfunc

" Delimiter pairs
iab jj {}<Left><C-R>=EatWhiteSpace()<CR>
iab ff ()<Left><C-R>=EatWhiteSpace()<CR>
iab dd ()<Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab ss []<Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab aa <><Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>

" Binary operators
iab hh =
iab gg +

" Punctuation
iab nn _<Left><BS><Right><C-R>=EatWhiteSpace()<CR>

" CtrlP keybindings
nnoremap <Space>f :CtrlP<CR>
nnoremap <Space>B :CtrlPBuffer<CR>
nnoremap <Space>m :CtrlPMRU<CR>
nnoremap <Space>t :CtrlPTag<CR>
nnoremap <Space>b :CtrlPBufTag<CR>
nnoremap <Space>q :CtrlPQuickfix<CR>
nnoremap <Space>d :CtrlPDir<CR>
