""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin paths
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.config/nvim/bundle/nvim-ipy
set runtimepath+=~/opt/fzf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable
set background=light
colorscheme solarized

" C++ header syntax highlighting
autocmd BufNewFile,BufRead *.h set filetype=cpp
" AIDL syntax highlighting
autocmd BufNewFile,BufRead *.aidl set filetype=java
" JavaScript Module syntax hightlighting
autocmd BufNewFile,BufRead *.jsm set filetype=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set smartindent
set shiftwidth=4
set softtabstop=4
set expandtab

" C++ indentation
" Don't indent within a namespace block
set cino=N-s

" Go indentation
function! SetupGoIndentation()
    set shiftwidth=0
    set softtabstop=0
    set tabstop=4
    set noexpandtab
endfunction
autocmd BufNewFile,BufRead *.go call SetupGoIndentation()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ruler
set colorcolumn=81,121

" Don't wrap lines
set nowrap

" Show line and column number in status bar
set ruler
" Show line numbers
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip trailing whitespace when writing a buffer
autocmd BufWritePre * :silent! %s/\s\+$//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not create swapfiles
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use m to enter commands
nnoremap m :

" Leader keybindings
let mapleader = "\<Space>"
" Go to tag definition
nnoremap <Leader>g <C-]>
" Select tag definition to go to
nnoremap <Leader>G g]
" Go back from tag definition
nnoremap <Leader>p <C-t>
" Unhighlight search results
nnoremap <Leader>h :nohlsearch<CR>
" FZF
nnoremap <Leader>f :FZF<CR>

" Menu keybindings

" A buffer local variable storing the current tab completion mode
autocmd BufEnter * let b:TabCompleteMode = 0

" When tab is pressed dismiss the current completion menu if it is visible.
" Cycle between omni-complete, previous match completion and next match
" completion.
function! TabComplete()
    let selectNextCompletion = "\<C-n>"
    let showCompleteModePrev = "\<C-p>"

    let menuVisible = pumvisible()

    if menuVisible
        return selectNextCompletion
    else
        let currentLine = getline('.')
        let cursorPosition = col('.')
        let currentLineBeforeCursor = strpart(currentLine, 0, (cursorPosition - 1))
        let isCurrentLineBeforeCursorWhitespace = (currentLineBeforeCursor =~ '^\s*$')

        if isCurrentLineBeforeCursorWhitespace
            return "\<Tab>"
        else
            return showCompleteModePrev
        endif
    endif
endfunction

inoremap <silent> <expr> <Tab> TabComplete()
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <

" When Enter is pressed and the popup menu is visible select the current
" completion. Otherwise insert a newline.
function! SelectCompletion()
    let menuVisible = pumvisible()

    if menuVisible
        return "\<C-y>"
    else
        return "\<CR>"
endfunction

inoremap <silent> <expr> <CR> SelectCompletion()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bell setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable bell
set noerrorbells
set visualbell

