if not vim.g.vscode then
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local servers = {
		"bashls",
		"clangd",
		"cmake",
		"csharp_ls",
		"cssls",
		"gopls",
		"html",
		"jdtls",
		"jsonls",
		"lua_ls",
		"marksman",
		"nixd",
		"intelephense",
		"pyright",
		"rust_analyzer",
		"sqls",
		"svelte",
		"tailwindcss",
		"terraformls",
		"ts_ls",
		"yamlls",
	}

	for _, server in ipairs(servers) do
		vim.lsp.config[server] = {
			capabilities = capabilities,
		}
	end

	vim.lsp.enable(servers)
end
