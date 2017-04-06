set nocompatible
syntax on
filetype off

call plug#begin('~/.vim/plugged')
"My Plugins here:
"
" original repos on github
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'derekwyatt/vim-scala'
Plug 'plasticboy/vim-markdown'
Plug 'buddhavs/vim-Rename' 
Plug 'joonty/vdebug'
Plug 'https://github.etsycorp.com/tschneiter/vim-github.git'
Plug 'https://github.etsycorp.com/Engineering/vim-rodeo.git'
Plug 'urthbound/hound.vim'
Plug 'mattn/webapi-vim'
Plug 'fatih/vim-go'
Plug 'reedes/vim-pencil'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'benekastah/neomake'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'
Plug 'elmcast/elm-vim'
Plug 'bogado/file-line'
Plug 'rust-lang/rust.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'hhvm/vim-hack'
Plug 'scrooloose/syntastic'

call plug#end()

" All of your Plugins must be added before the following line
filetype plugin indent on

syntax enable
set background=dark
" set background=light
let g:solarized_termtrans = 1
colorscheme solarized

let mapleader = ","

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
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

" neomake
let g:neomake_open_list = 2
let g:neomake_php_phpcs_args_standard = "/home/".expand($USER)."/development/Etsyweb/tests/standards/stable-ruleset.xml"
let g:neomake_php_enabled_makers = ["php", "phpcs"]
let g:neomake_javascript_enabled_makers = []
autocmd! BufWritePost * Neomake

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Status bar
set laststatus=2

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list=1
let g:syntastic_aggregate_errors=1
let g:syntastic_sort_aggregated_errors=1
let g:syntastic_quiet_messages = { "type": "style" }

if getcwd() =~ '/Etsyweb\(/\|$\)'
    let g:syntastic_javascript_checkers = ["eslint"]
    let g:syntastic_javascript_eslint_exec = "/usr/lib/node_modules/etsy-eslint/node_modules/.bin/eslint"
    let g:syntastic_javascript_eslint_args='--config /usr/lib/node_modules/etsy-eslint/config.json'
endif

if getcwd() =~ '/mott-ui\(/\|$\)'
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2

    let g:syntastic_javascript_checkers = ["eslint"]
    let g:syntastic_javascript_eslint_exec = "/home/dmiller/development/mott/node_modules/eslint/bin/eslint.js"
    autocmd FileType javascript set formatprg=prettier\ --single-quote\ --trailing-comma\ es5\ --stdin
    " autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
endif

if getcwd() =~ '/code-review\(/\|$\)'
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2

    let g:syntastic_javascript_checkers = ["eslint"]
endif

if getcwd() =~ '/deployinator\(/\|$\)'
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2
endif

" SuperTab Settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
            \ "&completefunc:<c-x><c-u>",
            \ "&omnifunc:<c-x><c-o>",
            \ ]
let g:SuperTabLongestHighlight = 1

" Show (partial) command in the status line
set showcmd

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
au BufRead,BufNewFile *.md setlocal textwidth=120
let g:vim_markdown_toc_autofit = 1

" Set up phpunit as the make program:
set makeprg=cd\ /home/dmiller/development/Etsyweb/tests/phpunit;\ pake\ $*

" Here's where the real magic happens.
" " Set the error format so that it can detect test failures,
" " In addition to other PHP interpreter errors (also one line)
set errorformat=%E%n)\ %.%#,%Z%f:%l,%C%m,%m\ in\ %f\ on\ line\ %l,%-G%.%#

"map muu :make unit_nosetup %:p:h<CR>
map muu :make unit_nosetup <C-R>#
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
    \    "port" : 9089,
    \    "server" : 'localhost',
    \    "timeout" : 20,
    \    "on_close" : 'detach',
    \    "break_on_open" : 0,
    \    "ide_key" : 'dmiller',
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
let g:syntastic_go_checkers = ["go", "gofmt"]
let g:syntastic_aggregate_errors = 1

au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd
autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" flow 
let g:flow#autoclose = 1
let g:flow#enable = 1
let g:javascript_plugin_flow = 1
let g:deoplete#sources#flow#flow_bin = 'flow' 

" elm
let g:elm_format_autosave = 1

" reason
" Merlin plugin
" let s:ocamlmerlin=substitute(system('opam config var share'),'\n$','','') . "/merlin"
" execute "set rtp+=".s:ocamlmerlin."/vim"
" execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
" let g:syntastic_ocaml_checkers=['merlin']

" " Reason plugin which uses Merlin
" let s:reasondir=substitute(system('opam config var share'),'\n$','','') . "/reason"
" execute "set rtp+=".s:reasondir."/editorSupport/VimReason"
" let g:syntastic_reason_checkers=['merlin']
" let g:syntastic_ignore_files = ['\m\c\.ml[ly]$']

" NERDcomment
let g:NERDSpaceDelims = 1

" Elm
" let g:elm_syntastic_show_warnings = 0

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" rust
" let g:rustfmt_autosave = 1 " hmm why doesn't this work

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" neosnippet configuration
let g:neosnippet#snippets_directory="/home/".expand($USER)."/.vim/plugged/vim-snippets/snippets"
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
