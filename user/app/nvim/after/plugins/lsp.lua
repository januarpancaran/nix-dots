if not vim.g.vscode then
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local servers = {
		"bashls",
		"clangd",
		"cmake",
		"cssls",
		"gopls",
		"html",
		"intelephense",
		"jdtls",
		"jsonls",
		"lua_ls",
		"marksman",
		"nixd",
		"omnisharp",
		"pyright",
		"rust_analyzer",
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
