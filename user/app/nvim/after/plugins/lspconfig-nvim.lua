local lsp_on_attach = function(_, bufnr)
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

if vim.lsp.inlay_hint then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end
		end,
	})
end

local servers = {
	bashls = {},
	clangd = {},
	cmake = {},
	csharp_ls = {},
	cssls = {},
	gopls = {},
	html = {},
	jdtls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		},
	},
	marksman = {},
	nixd = {
		settings = {
			nixd = {
				formatting = { command = { "alejandra" } },
			},
		},
	},
	intelephense = {},
	pyright = {},
	rust_analyzer = {},
	sqls = {},
	svelte = {},
	tailwindcss = {},
	terraformls = {},
	ts_ls = {},
	yamlls = {},
}

for server, config in pairs(servers) do
	local lsp = vim.lsp.config[server]

	if lsp and lsp.setup then
		lsp.setup(vim.tbl_extend("force", {
			on_attach = lsp_on_attach,
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		}, config))
	end
end
