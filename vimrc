""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package management setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/Command-T'
Plugin 'ervandew/ag'
Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'jnurmine/Zenburn'

call vundle#end()

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=256
set background=dark

" Use C++ syntax highlighting for header files
autocmd BufNewFile,BufRead *.h setfiletype cpp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  set guioptions-=T
  colors obsidian2
endif
if has('gui_macvim')
  set guifont=Menlo:h14
endif
if has('gui_gtk')
  set guifont=Liberation\ Mono\ 11
endif
if has('gui_win32')
  set guifont=Consolas:h12
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --others --exclude-standard'],
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
" These values are sufficient for the Android Open Source Project
let g:CommandTMaxFiles = 524288
let g:CommandTMaxDepth = 20
let g:CommandTMaxCachedDirectories = 16
let g:CommandTFileScanner = 'find'
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent
set shiftwidth=2
set softtabstop=2
set expandtab

" Java indentation
autocmd FileType java setlocal shiftwidth=4 softtabstop=4
" AIDL syntax highlighting
autocmd BufNewFile,BufRead *.aidl set filetype=java

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruler
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function BCSetColorColumn(...)
  let fileType = ''
  if a:0 == 1
    let fileType = a:1
  endif
  let columnByFileType = { 'java': 101 }
  let defaultColumn = 81
  let column = get(columnByFileType, fileType, defaultColumn)
  let &colorcolumn = join(range(column,999),',')
endfunction

highlight ColorColumn ctermbg=233 ctermfg=15
call BCSetColorColumn()
autocmd FileType java call BCSetColorColumn('java')

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

" Use m to enter commands
nnoremap m :

" Leader keybindings
let mapleader = "\<Space>"
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>B :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>b :CtrlPBufTag<CR>
nnoremap <Leader>q :CtrlPQuickfix<CR>
nnoremap <Leader>d :CtrlPDir<CR>
nnoremap <Leader>j :CtrlPQuickFix<CR>
nnoremap <Leader>g <C-]>
nnoremap <Leader>G g]
nnoremap <Leader>p <C-t>
nnoremap <Leader>h :set invhlsearch<CR>
nnoremap <Leader>c :pyf ~/vimfiles/clang-format.py<CR>
vnoremap <Leader>c :pyf ~/vimfiles/clang-format.py<CR>

" C++ indentation
" Don't indent within a namespace block
set cino=N-s
