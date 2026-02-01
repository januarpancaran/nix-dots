if not vim.g.vscode then
    require("nvim-treesitter").setup({
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })

    require("treesitter-context").setup()
end
