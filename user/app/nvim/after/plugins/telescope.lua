if not vim.g.vscode then
	local telescope = require("telescope")
	telescope.setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},

			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})

	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
end
