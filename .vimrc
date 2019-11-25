call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

syntax on
set number
set undofile
set showcmd

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


" Formatting stuff
syntax enable
set background=dark
" set background=light
let g:solarized_termtrans = 1
colorscheme solarized

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

nnoremap <C-P> :FZF<CR>


" Swap : and ; to make colon commands easier to type
nnoremap  ;  :


" Create new directories when adding a file where the parent directory doesn't
" exist
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Autocomplete
let g:deoplete#enable_at_startup = 1
command Rename call LanguageClient#textDocument_rename()
command GoToDefiniton call LanguageClient#textDocument_definition()
" command FindAllReferences 
command SymbolSearch call LanguageClient#textDocument_documentSymbol()
nnoremap <F5> :call LanguageClient_contextMenu()<CR><Paste>
