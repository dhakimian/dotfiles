call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'neovim/nvim-lspconfig'
Plug 'RRethy/vim-illuminate'
call plug#end()
nn <silent> ]r :lua require"illuminate".goto_next_reference()<CR>
nn <silent> [r :lua require"illuminate".goto_prev_reference()<CR>

lua require('cfg-min')
