set nocompatible

"filetype on  " prevent vim from exiting with nonzero status for some reason
"filetype off                  " required

" Their 'sensible' settings don't seem to be very sensible for my patterns of use at least..
let g:polyglot_disabled = ['sensible']

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'junegunn/vim-plug'

Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-dadbod'
Plug 'dhakimian/vim-db'
"Plug 'hhvm/vim-hack'
"Plug 'sheerun/vim-polyglot'
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
Plug 'vim-scripts/dbext.vim'
Plug 'dhakimian/vim-autoclose'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'RRethy/vim-illuminate'
if (has('python') || has('python3'))
    Plug 'SirVer/ultisnips'
    Plug 'thomasfaingnaert/vim-lsp-snippets'
    Plug 'thomasfaingnaert/vim-lsp-ultisnips'
else
    Plug 'garbas/vim-snipmate'
    Plug 'MarcWeber/vim-addon-mw-utils' "required for snipmate
    Plug 'tomtom/tlib_vim' "required for snipmate
endif
Plug 'honza/vim-snippets'

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
"com! JSONFormat %!python3 -m json.tool    (`%!jq .` is a simpler alternative)
runtime! macros/matchit.vim
"omnifunc will be overridden by LSP completion function if present
set omnifunc=syntaxcomplete#Complete
set completefunc=functions#UltiSnipsComplete
set copyindent
set timeoutlen=250
set ttimeoutlen=10
set wildmode=longest,list,full
set wildmenu
set completeopt=longest,menuone,noselect
set backspace=indent,eol
set tabstop=4
set shiftwidth=4
set nu
set signcolumn=number
set ruler
set showtabline=2
set laststatus=2
set list
set listchars=tab:\|\ ,trail:·,precedes:<,extends:>,nbsp:+
set virtualedit=block
set splitright
set splitbelow
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit
set showcmd
set nostartofline
set nohid
set mouse=
noremap <F1> <nop>
noremap K <nop>
"nn <silent> K :LspHover<CR>
"nn <silent> ]e :LspNextError<CR>
"nn <silent> ]r :LspNextReference<CR>
"nn <silent> [e :LspPreviousError<CR>
"nn <silent> [r :LspPreviousReference<CR>
nn <silent> ]r :lua require"illuminate".goto_next_reference()<CR>
nn <silent> [r :lua require"illuminate".goto_prev_reference()<CR>

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
no <Leader>p <C-w><C-z>
"prevent accidental Joins when quickly defining a selection with shift-V (DOuble INitial CAps problem)
"unfortunately, also prevents multi-line Joins of all visually selected lines
vn J j
vn K k
"restore ability to do multi-line Joins of all visually selected lines
vn <Leader>J J
" Move the cursor back to where it was when the visually selected block was
" yanked, instead of always jumping to the top.
vn y ygv

let g:AutoCloseProtectedRegions = ["Comment", "Character"]

let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<c-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsListSnippets = ''
let g:UltiSnipsEditSplit = 'tabdo'
let g:snipMate = { 'snippet_version' : 1 }

"let g:lsp_virtual_text_enabled = 0
"let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_signs_enabled = 1
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '‼'}
""let g:lsp_signs_hint = {'text': '💡'}

"let g:asyncomplete_auto_popup = 0
"imap <c-n> <Plug>(asyncomplete_force_refresh)

"let g:mucomplete#chains = {
"    \ 'default' : ['omni', 'ulti', 'keyn', 'c-n', 'dict', 'uspl'],
"    \ 'vim'     : ['cmd',  'ulti', 'keyn', 'c-n']
"    \ }
"imap <c-n> <plug>(MUcompleteFwd)
"imap <c-p> <plug>(MUcompleteBwd)

source ~/.vim/dbext_settings.vim
source ~/.vim/db_connections.vim
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'
xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbl <Plug>(DBExeLine)

"Replacing this previous method with the one provided at :help last-position-jump
""" Return the cursor to the position it was in when the buffer was last closed 
""function! ResCur()
""  if line("'\"") <= line("$")
""    normal! g`"
""    return 1
""  endif
""endfunction


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

"Credit: https://stackoverflow.com/a/30101152/5066751
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction

if has("autocmd")
    if !exists("autocom_loaded")
        let autocom_loaded = 1
        "au BufWinEnter * call ResCur()
        "Replacing this previous method with the one provided at :help last-position-jump
        au BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                    \ |   exe "normal! g`\""
                    \ | endif
        au BufWritePre * call LastModified()
        au BufRead,BufNewFile *.rkt,*.rktl set filetype=racket
        au BufRead,BufNewFile *.pl6,*.p6 set filetype=perl6
        au BufRead,BufNewFile *.md set filetype=markdown
        let g:xml_syntax_folding=1
        au FileType xml setlocal foldmethod=syntax

        "Doing this through vim-illuminate instead
        "autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        ""autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        "autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

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

"inoremap <silent> <expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>")

lua require('config')
lua require('vim-illuminate-cfg')
