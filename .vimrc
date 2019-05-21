set nocompatible
"execute pathogen#infect()

"filetype on  " prevent vim from exiting with nonzero status for some reason
"filetype off                  " required
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
Plug 'junegunn/vim-plug'

Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'hhvm/vim-hack'
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
Plug 'vim-scripts/dbext.vim'
Plug 'dhakimian/vim-autoclose'
"Plug 'lifepillar/vim-mucomplete'
"Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'prabirshrestha/asyncomplete-buffer.vim'
if (has('python') || has('python3'))
    Plug 'SirVer/ultisnips'
    "Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
else
    Plug 'garbas/vim-snipmate'
    Plug 'MarcWeber/vim-addon-mw-utils' "required for snipmate
    Plug 'tomtom/tlib_vim' "required for snipmate
endif
Plug 'honza/vim-snippets'

"call vundle#end()
call plug#end()
"syntax enable
"filetype plugin indent on
try
    set bg=dark | colo dhakimian
    com! Dark set bg=dark | colo dhakimian
    com! Light set bg=light | colo dhakimian
catch /^Vim\%((\a\+)\)\=:E185/
    set t_Co=16
    colo delek "This is the most bearable default colorscheme I've found (but only when colors are limited)
endtry
runtime! macros/matchit.vim
set omnifunc=syntaxcomplete#Complete
set completefunc=functions#UltiSnipsComplete
set copyindent
set timeoutlen=250
set ttimeoutlen=10
set wildmode=longest,list,full
set wildmenu
set completeopt=longest,menuone
set backspace=indent,eol
set tabstop=4
set shiftwidth=4
set nu
set ruler
set showtabline=2
set laststatus=2
set list
set listchars=tab:\|\ ,trail:·,precedes:<,extends:>
set virtualedit=block
set splitright
set splitbelow
set ignorecase
set smartcase
set incsearch
set showcmd
set nostartofline
noremap <F1> <nop>
noremap K <nop>
nn <silent> K :LspHover<CR>
nn <silent> ]e :LspNextError<CR>
nn <silent> ]r :LspNextReference<CR>
nn <silent> [e :LspPreviousError<CR>
nn <silent> [r :LspPreviousReference<CR>
set pastetoggle=<F2>
nn <Tab> gt
nn <S-Tab> gT
no Y y$
"for vim-surround
nmap S ys

if !has('nvim')
	set viminfo='10,\"100,:20,%,n~/.viminfo
endif
set undofile
set undodir=~/.vim/undo_history
set undolevels=1000
set undoreload=10000
let mapleader=" "
nn <Space> <nop>
nn <Leader><Leader> :nohl<CR>
nn <Leader>h <C-w><C-h>
nn <Leader>j <C-w><C-j>
nn <Leader>k <C-w><C-k>
nn <Leader>l <C-w><C-l>
no <Leader>c :set nu! list!<CR>
"prevent accidental Joins when quickly defining a selection with shift-V (DOuble INitial CAps problem)
"unfortunately, also prevents multi-line Joins of all visually selected lines
vn J j
vn K k
"restore ability to do multi-line Joins of all visually selected lines
vn <Leader>J J

let g:AutoCloseProtectedRegions = ["Comment", "Character"]

let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsListSnippets = ''
let g:UltiSnipsEditSplit = 'tabdo'

let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
"let g:lsp_signs_hint = {'text': '💡'}

"let g:asyncomplete_auto_popup = 0
"imap <c-n> <Plug>(asyncomplete_force_refresh)

"let g:mucomplete#chains = {
"    \ 'default' : ['omni', 'ulti', 'keyn', 'c-n', 'dict', 'uspl'],
"    \ 'vim'     : ['cmd',  'ulti', 'keyn', 'c-n']
"    \ }
"imap <c-n> <plug>(MUcompleteFwd)
"imap <c-p> <plug>(MUcompleteBwd)


" Return the cursor to the position it was in when the buffer was last closed
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before it (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last \(modified\|changed\?\):\s\+\).*#\1' .
          \ strftime('%Y-%m-%d') . '#ei'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

if has("autocmd")
    if !exists("autocom_loaded")
        let autocom_loaded = 1
        au BufWinEnter * call ResCur()
        au BufWritePre * call LastModified()
        au BufRead,BufNewFile *.rkt,*.rktl set filetype=racket
        au BufRead,BufNewFile *.pl6,*.p6 set filetype=perl6
        au BufRead,BufNewFile *.md set filetype=markdown
        let g:xml_syntax_folding=1
        au FileType xml setlocal foldmethod=syntax

        "TODO: separate things out to ftplugin/*.vim files
        if executable('intelephense')
            au User lsp_setup call lsp#register_server({
                \ 'name': 'intelephense',
                \ 'cmd': {server_info->['node', expand('/opt/local/lib/node_modules/intelephense/lib/intelephense.js'), '--stdio']},
                \ 'initialization_options': {"storagePath": "/tmp/intelephense"},
                \ 'whitelist': ['php'],
                \ })
            "au FileType php setlocal omnifunc=lsp#complete
        endif
        if executable('bash-language-server')
            au User lsp_setup call lsp#register_server({
                \ 'name': 'bash-language-server',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
                \ 'whitelist': ['sh'],
                \ })
            au FileType sh setlocal omnifunc=lsp#complete
        endif

        "call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        "    \ 'name': 'buffer',
        "    \ 'whitelist': ['*'],
        "    \ 'blacklist': ['go'],
        "    \ 'completor': function('asyncomplete#sources#buffer#completor'),
        "    \ }))
        "
        "if (has('python') || has('python3'))
        "    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        "        \ 'name': 'ultisnips',
        "        \ 'whitelist': ['*'],
        "        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        "        \ }))
        "endif

    endif
endif


"inoremap {<CR> {<CR>}<Esc>O
"inoremap <silent> <expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>")
