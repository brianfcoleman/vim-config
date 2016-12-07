""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin paths
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.config/nvim/ctrlp.vim,~/.config/nvim/vim-clang-format,~/.config/nvim/vim-fugitive,~/.fzf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable
set background=dark

" C++ header syntax highlighting
autocmd BufNewFile,BufRead *.h set filetype=cpp
" AIDL syntax highlighting
autocmd BufNewFile,BufRead *.aidl set filetype=java
" JavaScript Module syntax hightlighting
autocmd BufNewFile,BufRead *.jsm set filetype=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:DefaultIndentation = 4
let g:Indentation = 0
autocmd BufEnter * let b:Indentation = 0

function! UpdateIndentation(indentation)
    let &shiftwidth = a:indentation
    let &softtabstop = a:indentation
endfunction

function! OverrideGlobalIndentation(indentation)
    let g:Indentation = str2nr(a:indentation)
    call UpdateIndentation(g:Indentation)
endfunction

function! RemoveGlobalIndentationOverride()
    let g:Indentation = 0
endfunction

function! OverrideBufferIndentation(indentation)
    let b:Indentation = str2nr(a:indentation)
    call UpdateIndentation(b:Indentation)
endfunction

function! RemoveBufferIndentationOverride()
    let b:Indentation = 0
endfunction

function! GetDefaultIndentation(filetype)
    let indentationsByFiletype = {
                \ 'cpp': 2,
                \ 'py': 2
                \ }
    if has_key(indentationsByFiletype, a:filetype)
        return indentationsByFiletype[a:filetype]
    else
        return g:DefaultIndentation
    endif
endfunction

function! SetupIndentation(filetype)
    let indentation = GetDefaultIndentation(a:filetype)
    if g:Indentation
        let indentation = g:Indentation
    endif
    call UpdateIndentation(indentation)
endfunction

autocmd BufEnter * call SetupIndentation(&filetype)

command! -nargs=1 OverrideGlobalIndentation call OverrideGlobalIndentation(<f-args>)
command! RemoveGlobalIndentationOverride call RemoveGlobalIndentationOverride()
command! -nargs=1 OverrideBufferIndentation call OverrideBufferIndentation(<f-args>)
command! RemoveBufferIndentationOverride call RemoveBufferIndentationOverride()
command! SetupIndentation call SetupIndentation(&filetype)

set smartindent
set expandtab
let &shiftwidth = g:DefaultIndentation
let &softtabstop = g:DefaultIndentation

" C++ indentation
function! SetupCppIndentation()
    " Don't indent within a namespace block
    set cino=N-s
    set smartindent
    set expandtab
endfunction
autocmd BufNewFile,BufRead *.h,*.hh,*.hpp,*.hxx,*.c,*.cc,*.cpp,*.cxx call SetupCppIndentation()

" Python indentation
function! SetupPythonIndentation()
    set smartindent
    set expandtab
endfunction
autocmd BufNewFile,BufRead *.py call SetupPythonIndentation()

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
" Fuzzy file finder
nnoremap <Leader>f :call fzf#run({'source': 'git ls-files', 'sink': 'e'})<CR>
nnoremap <Leader>F :FZF<CR>
" CtrlP find buffer mode
nnoremap <Leader>b :CtrlPBuffer<CR>
" Run clang format
nnoremap <Leader>c :<C-u>ClangFormat<CR>
vnoremap <Leader>c :ClangFormat<CR>

" Menu keybindings

" A buffer local variable storing the current tab completion mode
autocmd BufEnter * let b:TabCompleteMode = 0

let g:UseOmniComplete = 0

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
        if hasOmniComplete && g:UseOmniComplete
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
        elseif hasOmniComplete && g:UseOmniComplete
            if (b:TabCompleteMode == TabCompleteModeOmni)
                let b:TabCompleteMode = TabCompleteModePrev
                " If we tried to show the omni-complete popup menu but no
                " completions were available we will still be in omni-complete
                " mode. We can use <C-e> to exit omni-complete mode in this
                " case.
                return showCompleteModePrev
            elseif (b:TabCompleteMode == TabCompleteModePrev)
                let b:TabCompleteMode = TabCompleteModeNext
                return showCompleteModeNext
            elseif (b:TabCompleteMode == TabCompleteModeNext)
                let b:TabCompleteMode = TabCompleteModeOmni
                return showCompleteModeOmni
            endif
        else
            if (b:TabCompleteMode == TabCompleteModeOmni)
                " If we tried to show the omni-complete popup menu but no
                " completions were available we will still be in omni-complete
                " mode. We can use <C-e> to exit omni-complete mode in this
                " case.
                let b:TabCompleteMode = TabCompleteModePrev
                return showCompleteModePrev
            elseif (b:TabCompleteMode == TabCompleteModePrev)
                let b:TabCompleteMode = TabCompleteModeNext
                return showCompleteModeNext
            elseif (b:TabCompleteMode == TabCompleteModeNext)
                let b:TabCompleteMode = TabCompleteModePrev
                return showCompleteModePrev
            endif
        endif
    endif
    return "\<Tab>"
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
" ctrlp.vim setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_match_window = 'max:48'
let g:ctrlp_max_files = 262144
let g:ctrlp_max_depth = 128
let g:ctrlp_user_command = ['.git', 'cd /d %s && git ls-files']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-clang-format setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#code_style = "Chromium"
let g:clang_format#detect_style_file = 0

