if not vim.g.vscode then
	require("neo-tree").setup({
		close_if_last_window = false,

		popup_border_style = "rounded",

		enable_git_status = true,
		enable_diagnostics = true,

		filesystem = {
			follow_current_file = {
				enabled = true,
			},

			hijack_netrw_behavior = "open_default",

			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},

		window = {
			position = "right",
			width = 30,

			mappings = {
				["<space>"] = "toggle_node",
				["<CR>"] = "open",
				["o"] = "open",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["C"] = "close_node",
				["R"] = "refresh",
				["H"] = "toggle_hidden",
			},
		},

		default_component_configs = {
			indent = {
				padding = 1,
				with_markers = true,
			},
			git_status = {
				symbols = {
					added = "+",
					modified = "~",
					deleted = "✖",
					renamed = "➜",
					untracked = "?",
					ignored = "◌",
					unstaged = "!",
					staged = "✓",
					conflict = "",
				},
			},
		},
	})
end
