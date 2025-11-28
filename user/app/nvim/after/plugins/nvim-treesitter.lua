if not vim.g.vscode then
	require("nvim-treesitter.configs").setup({
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
end
