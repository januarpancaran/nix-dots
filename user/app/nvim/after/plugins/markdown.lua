if not vim.g.vscode then
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    })

    require("render-markdown").setup()
end
