LspConfig = require('lspconfig')

local on_attach = function(client, bufnr)
	local buf_keymap_opts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', buf_keymap_opts)
end

local servers = {
	intelephense = {},
	bashls = {},
	vimls = {},
	sumneko_lua = {},
	tsserver = {},
}
for lsp,opts in pairs(servers) do
	local setup_options = {
		on_attach = on_attach,
	}
	for field,value in pairs(opts) do
		setup_options[field] = value
	end
	LspConfig[lsp].setup(setup_options)
end
