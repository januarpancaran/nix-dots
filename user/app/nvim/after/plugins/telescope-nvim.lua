if not vim.g.vscode then
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})

	require("telescope").load_extension("ui-select")
end
