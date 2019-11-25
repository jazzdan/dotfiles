call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdcommenter'

call plug#end()

syntax on
set number
set undofile
set showcmd

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
