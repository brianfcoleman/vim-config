""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable
set background=dark

" C++ header syntax highlighting
autocmd BufNewFile,BufRead *.h setfiletype cpp
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

" Menu keybindings

" A buffer local variable storing the current tab completion mode
autocmd BufEnter * let b:TabCompleteMode = 0

" When tab is pressed dismiss the current completion menu if it is visible.
" Cycle between omni-complete, previous match completion and next match
" completion.
function! TabComplete()
    let TabCompleteModeOmni=0
    let TabCompleteModePrev=1
    let TabCompleteModeNext=2

    let dismissMenuAndShowCompleteModeOmni = "\<C-e>\<C-x>\<C-o>"
    let dismissMenuAndShowCompleteModePrev = "\<C-e>\<C-p>"
    let dismissMenuAndShowCompleteModeNext = "\<C-e>\<C-n>"

    let showCompleteModeOmni = "\<C-x>\<C-o>"
    let showCompleteModePrev = "\<C-p>"
    let showCompleteModeNext = "\<C-n>"

    let hasOmniComplete = !empty("omnifunc")
    let menuVisible = pumvisible()

    if menuVisible
        if hasOmniComplete
            if (b:TabCompleteMode == TabCompleteModeOmni)
                let b:TabCompleteMode = TabCompleteModePrev
                return dismissMenuAndShowCompleteModePrev
            elseif (b:TabCompleteMode == TabCompleteModePrev)
                let b:TabCompleteMode = TabCompleteModeNext
                return dismissMenuAndShowCompleteModeNext
            elseif (b:TabCompleteMode == TabCompleteModeNext)
                let b:TabCompleteMode = TabCompleteModeOmni
                return dismissMenuAndShowCompleteModeOmni
            endif
        else
            if (b:TabCompleteMode == TabCompleteModeOmni)
                let b:TabCompleteMode = TabCompleteModePrev
                return dismissMenuAndShowCompleteModePrev
            elseif (b:TabCompleteMode == TabCompleteModePrev)
                let b:TabCompleteMode = TabCompleteModeNext
                return dismissMenuAndShowCompleteModeNext
            elseif (b:TabCompleteMode == TabCompleteModeNext)
                let b:TabCompleteMode = TabCompleteModePrev
                return dismissMenuAndShowCompleteModePrev
            endif
        endif
    else
        let currentLine = getline('.')
        let cursorPosition = col('.')
        let currentLineBeforeCursor =
\           strpart(currentLine, 0, (cursorPosition - 1))
        let isCurrentLineBeforeCursorWhitespace =
\           (currentLineBeforeCursor =~ '^\s*$')

        if isCurrentLineBeforeCursorWhitespace
            return "\<Tab>"
        elseif hasOmniComplete
            if (b:TabCompleteMode == TabCompleteModeOmni)
                let b:TabCompleteMode = TabCompleteModePrev
                " If we tried to show the omni-complete popup menu but no
                " completions were available we will still be in omni-complete
                " mode. We can use <C-e> to exit omni-complete mode in this
                " case.
                return dismissMenuAndShowCompleteModePrev
            else
                let b:TabCompleteMode = TabCompleteModePrev
                return showCompleteModePrev
            endif
        else
            if (b:TabCompleteMode == TabCompleteModeOmni)
                " If we tried to show the omni-complete popup menu but no
                " completions were available we will still be in omni-complete
                " mode. We can use <C-e> to exit omni-complete mode in this
                " case.
                let b:TabCompleteMode = TabCompleteModePrev
                return dismissMenuAndShowCompleteModePrev
            else
                let b:TabCompleteMode = TabCompleteModePrev
                return showCompleteModePrev
            endif
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/opt/fzf
