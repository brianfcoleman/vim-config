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
" CommandT setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp^=~/.vim/command-t
let g:CommandTMaxCachedDirectories = 8

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

" C-like syntax statemant completion
iab mm <Esc>A;<Esc>

" Remove the character underneath the cursor if it is a space
func EatWhiteSpace()
  let c = nr2char(getchar(0))
  return (c =~ '\s') ? '' : c
endfunc

" Delimiter pairs
iab ff {}<Left><C-R>=EatWhiteSpace()<CR>
iab FF {}<Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab dd ()<Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab DD ()<Left><C-R>=EatWhiteSpace()<CR>
iab ss []<Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab aa <><Left><Left><BS><Right><C-R>=EatWhiteSpace()<CR>
iab rr ""<Left><C-R>=EatWhiteSpace()<CR>
iab RR ''<Left><C-R>=EatWhiteSpace()<CR>

" Binary operators
iab uu =
iab ii ==
iab II !=
iab oo +
iab OO -

" Punctuation
iab ee _<Left><BS><Right><C-R>=EatWhiteSpace()<CR>

" Arrow key alternative mapping
noremap <M-H> <Left>
noremap <M-J> <Down>
noremap <M-K> <Up>
noremap <M-L> <Right>

" Omni complete keybinding
inoremap <F8> <C-P>
inoremap <F9> <C-X><C-O>

" CommandT keybindings
nnoremap <Space>f :CommandT<CR>
" CtrlP keybindings
nnoremap <Space>B :CtrlPBuffer<CR>
nnoremap <Space>m :CtrlPMRU<CR>
nnoremap <Space>t :CtrlPTag<CR>
nnoremap <Space>b :CtrlPBufTag<CR>
nnoremap <Space>q :CtrlPQuickfix<CR>
nnoremap <Space>d :CtrlPDir<CR>

" C++ indentation
" Don't indent within a namespace block
set cino=N-s
