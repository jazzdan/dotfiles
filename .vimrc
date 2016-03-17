set nocompatible
syntax on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

"My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'vim-phpcs'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'derekwyatt/vim-scala'
Plugin 'plasticboy/vim-markdown'
Plugin 'joonty/vim-phpunitqf' 
Plugin 'buddhavs/vim-Rename'
Plugin 'joonty/vdebug.git'
Plugin 'https://github.etsycorp.com/tschneiter/vim-github.git'
Plugin 'https://github.com/hhvm/vim-hack.git'
Plugin 'urthbound/hound.vim'
Plugin 'mattn/webapi-vim'
Plugin 'fatih/vim-go'
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'benekastah/neomake'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'flowtype/vim-flow'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

syntax enable
set background=dark
"set background=light
let g:solarized_termtrans = 1
colorscheme solarized

let mapleader = ","

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set number

set history=1000                   " keeps a thousand lines of history
set magic                          " allows pattern matching with special characters
set backspace=2                    " make backspace work like normal
set visualbell                     " visual bell instead of annoying beeping
set mouse=a                        " enable full mouse support in the console
set virtualedit=onemore            " end of the line? what's that?

set path=~/development/Etsyweb/phplib/EtsyModel,~/development/Etsyweb/phplib,~/development/Etsyweb/templates
set includeexpr=substitute(v:fname,'_','/','g').'.php'
set suffixesadd=.tpl
set suffixesadd=.js
set suffixesadd=.mustache

" Undo stuff!
set undofile

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" reindent whole file
nnoremap <leader>r ggVG=
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" escape from terminal mode
tnoremap <Esc> <C-\><C-n>

" set PHP coding standard and call on writing php files
"au BufReadPost * if getfsize(bufname("%")) > 102400 | set syntax= | endif
let g:syntastic_phpcs_conf = "--standard=/home/".expand($USER)."/development/Etsyweb/tests/standards/stable-ruleset.xml"

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Status bar
set laststatus=2

" Enable syntastic syntax checking
let g:syntastic_enable_signs=0
let g:syntastic_quiet_messages = {'level': 'warnings'}
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_auto_loc_list=1
"let g:syntastic_loc_list_height=5
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "passive_filetypes": ["hh"] }

if getcwd() =~ '/Etsyweb\(/\|$\)'
    let g:syntastic_javascript_checkers = ["eslint"]
    let g:syntastic_javascript_eslint_exec = "/usr/lib/node_modules/etsy-eslint/node_modules/.bin/eslint"
    let g:syntastic_javascript_eslint_args='--config /usr/lib/node_modules/etsy-eslint/config.json'
endif

if getcwd() =~ '/mott\(/\|$\)'
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2

    let g:syntastic_javascript_checkers = ["eslint"]
    let g:syntastic_javascript_eslint_exec = "/home/dmiller/development/mott/node_modules/eslint/bin/eslint.js"
endif


" SuperTab Settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
            \ "&completefunc:<c-x><c-u>",
            \ "&omnifunc:<c-x><c-o>",
            \ ]
let g:SuperTabLongestHighlight = 1

" Show (partial) command in the status line
set showcmd

function! g:ToggleNuMode()
    if(&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc
nnoremap <C-L> :call g:ToggleNuMode()<cr>
nnoremap <C-P> :FZF<CR>

" OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============

" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
"nnoremap <silent> N   N:call HLNext(0.4)<cr>

"" OR ELSE just highlight the match in red...
"function! HLNext (blinktime)
    "let [bufnum, lnum, col, off] = getpos('.')
    "let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    "let target_pat = '\c\%#'.@/
    "let ring = matchadd('WhiteOnRed', target_pat, 101)
    "redraw
    "exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    "call matchdelete(ring)
    "redraw
"endfunction

"====[ Swap : and ; to make colon commands easier to type ]======

nnoremap  ;  :

" Helpers for github and gist
" " Link to file in github
map <leader>G :Github<CR>
" " Link to file in github with lines hilighted
map <leader>g :Github l<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class     " MacOSX/Linux

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

" Set character wrap level to 80 on markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

" Set up phpunit as the make program:
set makeprg=cd\ /home/dmiller/development/Etsyweb/tests/phpunit;\ pake\ $*

" Here's where the real magic happens.
" " Set the error format so that it can detect test failures,
" " In addition to other PHP interpreter errors (also one line)
set errorformat=%E%n)\ %.%#,%Z%f:%l,%C%m,%m\ in\ %f\ on\ line\ %l,%-G%.%#

map muu :make unit_nosetup %:p:h<CR>
map mmu :make unit_nosetup
map mmU :make unit
map mmi :make integration_nosetup
map mmI :make integration
map mmf :make flaky_nosetup
map mmf :make flaky

" I don't auto-open the quickfix window, I use a binding or that:
map cx :cwindow<CR>
"
" " I don't let Syntastic auto open its window either:
map ex :Error<CR>

set smartcase

let g:vim_markdown_folding_disabled=1

let g:hound_base_url="hound.etsycorp.com"

let g:fugitive_github_domains = ['github.etsycorp.com']

let g:vdebug_options= {
    \    "port" : 9998,
    \    "server" : '',
    \    "timeout" : 20,
    \    "on_close" : 'detach',
    \    "break_on_open" : 0,
    \    "ide_key" : '',
    \    "path_maps" : {},
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'expanded',
    \    "marker_default" : '⬦',
    \    "marker_closed_tree" : '▸',
    \    "marker_open_tree" : '▾'
    \}

let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ["go", "gofmt", "golint", "govet"]
let g:syntastic_aggregate_errors = 1

au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
    autocmd FileType text         call pencil#init()
augroup END

" flow 
let g:flow#autoclose = 1
