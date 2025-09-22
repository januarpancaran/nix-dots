vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end
})
