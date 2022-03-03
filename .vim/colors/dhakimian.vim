" Vim color file
" Maintainer:   Daniel Hakimian <dhakimian@nwss.co>
" Last Change:  2022-03-03

set t_Co=256
highlight clear
let g:colors_name="dhakimian"

" Daniel Hakimian's personal ViM colorscheme
"
" The default colors for a light background worked pretty well on a black
" background. At least, they looked a lot better to me than the default colors
" for a dark background, so the light bg colors are the ones I would use
" (except when doing vimdiff -- there the dark colors worked much better),
" though with a few minor changes that I would put in my .vimrc, like making
" comments a lighter blue and changing the fold color. As time went on, I
" ended up making quite a few more small modifications here and there to the
" default colors, and then at a certain point, there were enough differences
" that I decided I might as well just go all out and make a full colorscheme.
"
" This colorscheme is based heavily on the default light bg colorscheme,
" but designed for use on a black background; modified as such for better
" readability and what looks nice to me, taking advantage of the full 256
" color range instead of just the standard 16.

" But then I got a white desk, and the contrast between a white desk and a
" black screen was just a bit too much for my eyes, so I decided to give in
" and start getting used to a white screen, at least temporarily. It was clear
" from the start that, like before, the default colors were close, but not
" quite there, even on the white background they were designed for, so I gave
" them the same treatment as before, but this time for use on a white
" background. It's pretty much the same basic colorscheme as the dark version,
" just essentially inverting most of the grayscale colors, and with a few
" minor differences where necessary or fitting. It works okay, but for some
" things, like diff mode, the dark version currently still works better.


" TODO: sort hi statements in reasonable order

if &bg == "light"
    hi   Normal       cterm=None       ctermfg=16    ctermbg=231
   "hi   Comment      cterm=None       ctermfg=63    ctermbg=None
    hi   Comment      cterm=None       ctermfg=245   ctermbg=None
   "hi   MatchParen   cterm=None       ctermfg=None  ctermbg=254
    hi   MatchParen   cterm=bold       ctermfg=0     ctermbg=254
   "hi   LineNr       cterm=None       ctermfg=242   ctermbg=255
    hi   LineNr       cterm=None       ctermfg=245   ctermbg=254
    hi   Constant     cterm=None       ctermfg=124   ctermbg=None
   "hi   Constant     cterm=None       ctermfg=160   ctermbg=None
    hi   String       cterm=None       ctermfg=28    ctermbg=None
    hi   Type         cterm=bold       ctermfg=40    ctermbg=None
    hi   Function     cterm=None       ctermfg=93    ctermbg=None
    hi   Identifier   cterm=None       ctermfg=31    ctermbg=None
    hi   Delimiter    cterm=None       ctermfg=200   ctermbg=None
   "hi   Folded       cterm=bold       ctermfg=207   ctermbg=None
   "hi   FoldColumn   cterm=bold       ctermfg=207   ctermbg=None
    hi   Folded       cterm=bold       ctermfg=21    ctermbg=None
    hi   FoldColumn   cterm=bold       ctermfg=21    ctermbg=None
    hi   ColorColumn  cterm=None       ctermfg=None  ctermbg=224
    hi   CursorLine   cterm=None       ctermfg=None  ctermbg=255
    hi   CursorLineNr cterm=None       ctermfg=130   ctermbg=None
    hi   Visual       cterm=None       ctermfg=None  ctermbg=253
    hi   NonText      cterm=bold       ctermfg=63    ctermbg=231
    hi   SpecialKey   cterm=None       ctermfg=248   ctermbg=None
    hi   Whitespace   cterm=None       ctermfg=248   ctermbg=None
    hi   TabLine      cterm=underline  ctermfg=16    ctermbg=252
    hi   TabLineFill  cterm=None       ctermfg=None  ctermbg=244
    hi   TabLineSel   cterm=bold       ctermfg=16    ctermbg=None
    hi   StatusLine   cterm=bold       ctermfg=231   ctermbg=16
    hi   StatusLineNC cterm=None       ctermfg=16    ctermbg=251
"diff colors don't work quite as well here as with the dark version
    hi   DiffAdd      cterm=None       ctermfg=None  ctermbg=22
    hi   DiffDelete   cterm=None       ctermfg=12    ctermbg=38
    hi   DiffChange   cterm=None       ctermfg=None  ctermbg=127
    hi   DiffText     cterm=None       ctermfg=None  ctermbg=124
    hi   SpellBad     cterm=None       ctermfg=231   ctermbg=197
    hi   SpellCap     cterm=None       ctermfg=231   ctermbg=27
    hi   SpellLocal   cterm=None       ctermfg=231   ctermbg=45
    hi   SpellRare    cterm=None       ctermfg=231   ctermbg=201

else "bg == "dark"
    hi   Normal       cterm=None       ctermfg=249   ctermbg=16
    hi   Comment      cterm=None       ctermfg=243   ctermbg=None
   "hi   Comment      cterm=None       ctermfg=63    ctermbg=None
   "hi   Comment      cterm=None       ctermfg=69    ctermbg=None
   "hi   MatchParen   cterm=None       ctermfg=None  ctermbg=20
    hi   MatchParen   cterm=bold       ctermfg=255   ctermbg=235
   "hi   LineNr       cterm=None       ctermfg=242   ctermbg=233
   "hi   LineNr       cterm=None       ctermfg=240   ctermbg=235
    hi   LineNr       cterm=None       ctermfg=242   ctermbg=234
    hi   Folded       cterm=bold       ctermfg=207   ctermbg=None
    hi   FoldColumn   cterm=bold       ctermfg=207   ctermbg=None
    hi   ColorColumn  cterm=None       ctermfg=None  ctermbg=17
    hi   CursorLine   cterm=None       ctermfg=None  ctermbg=233
    hi   CursorLineNr cterm=None       ctermfg=254   ctermbg=None
    hi   NonText      cterm=None       ctermfg=63    ctermbg=232
    hi   Visual       cterm=None       ctermfg=None  ctermbg=240
    hi   String       cterm=None       ctermfg=34    ctermbg=None
   "hi   String       cterm=None       ctermfg=40    ctermbg=None
   "hi   Type         cterm=None       ctermfg=46    ctermbg=None
    hi   Type         cterm=bold       ctermfg=40    ctermbg=None
   "hi   Pmenu        cterm=None       ctermfg=233   ctermbg=177
    hi   Pmenu        cterm=None       ctermfg=233   ctermbg=141
    hi   PmenuSel     cterm=None       ctermfg=233   ctermbg=189
    hi   PmenuSbar    cterm=None       ctermfg=None  ctermbg=139
    hi   PmenuThumb   cterm=None       ctermfg=None  ctermbg=251
    hi   Function     cterm=None       ctermfg=135   ctermbg=None
    hi   Identifier   cterm=bold       ctermfg=38    ctermbg=None
    hi   Delimiter    cterm=None       ctermfg=214   ctermbg=None
   "hi   Delimiter    cterm=None       ctermfg=208   ctermbg=None
    hi   Statement    cterm=None       ctermfg=130   ctermbg=None
   "hi   Constant     cterm=None       ctermfg=124   ctermbg=None
    hi   Constant     cterm=None       ctermfg=160   ctermbg=None
    hi   PreProc      cterm=None       ctermfg=207   ctermbg=None
   "hi   PreProc      cterm=None       ctermfg=133   ctermbg=None
    hi   Special      cterm=None       ctermfg=201   ctermbg=None
    hi   SpecialKey   cterm=None       ctermfg=20    ctermbg=233
    hi   Whitespace   cterm=None       ctermfg=20    ctermbg=233
    hi   Directory    cterm=None       ctermfg=63    ctermbg=None
    hi   Title        cterm=None       ctermfg=201   ctermbg=None
    hi   TabLine      cterm=underline  ctermfg=16    ctermbg=247
    hi   TabLineFill  cterm=None       ctermfg=None  ctermbg=250
    hi   TabLineSel   cterm=bold       ctermfg=231   ctermbg=None
    hi   StatusLine   cterm=bold       ctermfg=16    ctermbg=231
    hi   StatusLineNC cterm=None       ctermfg=16    ctermbg=244
    hi   Question     cterm=None       ctermfg=40    ctermbg=None
    hi   MoreMsg      cterm=None       ctermfg=40    ctermbg=None
    hi   ModeMsg      cterm=bold       ctermfg=231   ctermbg=None
    hi   WarningMsg   cterm=None       ctermfg=160   ctermbg=None
    hi   ErrorMsg     cterm=bold       ctermfg=231   ctermbg=124
    hi   Error        cterm=None       ctermfg=231   ctermbg=196
    hi   Todo         cterm=None       ctermfg=16    ctermbg=231
    hi   Search       cterm=None       ctermfg=None  ctermbg=226
    hi   DiffAdd      cterm=None       ctermfg=None  ctermbg=22
    hi   DiffDelete   cterm=None       ctermfg=21    ctermbg=30
    hi   DiffChange   cterm=None       ctermfg=None  ctermbg=90
    hi   DiffText     cterm=None       ctermfg=None  ctermbg=88
    hi   SpellBad     cterm=None       ctermfg=16    ctermbg=160
    hi   SpellCap     cterm=None       ctermfg=16    ctermbg=20
    hi   SpellLocal   cterm=None       ctermfg=16    ctermbg=45
    hi   SpellRare    cterm=None       ctermfg=16    ctermbg=164
endif
" Nice spaced out format courtesy of the column utility
" Select the lines in Visual mode and type this command:
" :'<,'>!column -t

" -- Highlight groups from old vim-lsp plugin. Keeping for reference of what colors I used --
"" LSP highlighting (Same colors work for both light and dark schemes)
"hi  LspReference         cterm=underline  ctermfg=None  ctermbg=None
"hi  LspErrorHighlight    cterm=None       ctermfg=231   ctermbg=196
"hi  LspErrorText         cterm=None       ctermfg=231   ctermbg=196
"hi  LspWarningHighlight  cterm=None       ctermfg=16    ctermbg=208
"hi  LspWarningText       cterm=None       ctermfg=16    ctermbg=208
"hi  LspHintHighlight     cterm=None       ctermfg=None  ctermbg=159
"hi  LspHintText          cterm=None       ctermfg=None  ctermbg=159
""hi LspInformationHighlight
""hi LspInformationText
"------------------------

"------ NeoVim builtin LSP highlight groups ------
hi  LspReferenceText   cterm=underline  ctermfg=None  ctermbg=None
hi  LspReferenceRead   cterm=underline  ctermfg=None  ctermbg=None
hi  LspReferenceWrite  cterm=underline  ctermfg=None  ctermbg=235
"hi LspSignatureActiveParameter cterm=None ctermfg=None ctermbg=255 changing this to match PmenuSel
hi LspSignatureActiveParameter cterm=None ctermfg=None ctermbg=189

"hi  DiagnosticError  ...
hi  DiagnosticWarn   cterm=None  ctermfg=208  ctermbg=None
"hi  DiagnosticHint   cterm=None  ctermfg=159  ctermbg=None
"hi  DiagnosticInfo   ...
hi  DiagnosticUnderlineError  cterm=None  ctermfg=231   ctermbg=196
hi  DiagnosticUnderlineWarn   cterm=None  ctermfg=16    ctermbg=208
hi  DiagnosticUnderlineHint   cterm=None  ctermfg=None  ctermbg=253
"hi  DiagnosticUnderlineInfo
"-------------------------------------------------

" These are copied from after/syntax/php.vim, since changing the colorscheme
" within a buffer clears these highlight groups and doesn't reset them
hi link phpIfSingleEqual phpConditional
hi link phpSingleEqualCondition Error

"hi Cursor		
"hi CursorIM	
"hi VertSplit	
"hi IncSearch	
"hi VisualNOS	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
"hi Underlined	
"hi Ignore		

" Very useful color chart that I've been using:
"   http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors
