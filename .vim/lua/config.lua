local LspConfig = require('lspconfig')
-- Only show virtual text for WARN and ERROR diagnostics
vim.diagnostic.config({virtual_text = {severity = {min=vim.diagnostic.severity.WARN}}})
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local keymap_opts = { noremap=true, silent=true }
--vim.keymap.set('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', keymap_opts)
--vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymap_opts)
--vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymap_opts)
--vim.keymap.set('n', '<space>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', keymap_opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, keymap_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, keymap_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

	-- Auto-display signature help through the use of a plugin
	local lsp_sig_cfg = {
		--doc_lines = 10,
		doc_lines = 0, -- signature help in normal mode (<C-k> as defined below) will still show doc lines
		--floating_window_off_x = 0,
		--floating_window_off_y = 0,
		hint_enable = false,
		handler_opts = {
			border = "none"   -- double, rounded, single, shadow, none
		},
		--auto_close_after = 2,  -- affects the manual floating window, not the automatic one...
		toggle_key = '<C-l>'
	}
	require 'lsp_signature'.on_attach(lsp_sig_cfg, bufnr)

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local buf_keymap_opts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_keymap_opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_keymap_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_keymap_opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_keymap_opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_keymap_opts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, buf_keymap_opts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, buf_keymap_opts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, buf_keymap_opts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, buf_keymap_opts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, buf_keymap_opts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, buf_keymap_opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_keymap_opts)
	vim.keymap.set('n', '<space>=', function()
		vim.lsp.buf.format { async = true }
	end, buf_keymap_opts)

end
local on_attach_omni = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	--old method-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

	on_attach(client, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
--  map buffer local keybindings when the language server attaches.
-- Keys to be passed to setup are also defined here, though one key (omni) is not for setup, but instead
--  a flag for whether to use the LSP omnifunc instead of whatever omnifunc is set to by default.
-- Don't forget to update `filetypes_allowlist` in ~/.vim/lua/vim-illuminate-cfg.lua if adding a server.
local servers = {
	intelephense = { omni=true, settings = { intelephense = {
		environment = { phpVersion = '7.4.33' }
	} } },
	bashls = { omni=true },
	vimls = { omni=true },
	sumneko_lua = { omni=true },
	--quick_lint_js = { omni=false },
	--eslint = { omni=false },
	tsserver = { omni=true },
	metals = { omni=true, root_dir = LspConfig.util.root_pattern("root.sbt", "build.sbt", "build.sc", "build.gradle", "pom.xml") },
}
for lsp,opts in pairs(servers) do
	local setup_options = { -- shared base/default options; could be overwritten if key is specified in the option tables under `servers` above
		on_attach = on_attach,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		}
	}
	if opts.omni then
		setup_options.on_attach = on_attach_omni
	end
	for field,value in pairs(opts) do
		if field ~= 'omni' then
			setup_options[field] = value
		end
	end
	LspConfig[lsp].setup(setup_options)
end
