-- leader
vim.g.mapleader = " "

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

-- scroll
vim.o.scrolloff = 10
vim.o.wrap = true

-- tab
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- indent
vim.o.smartindent = true
vim.o.autoindent = true

-- search
vim.o.hlsearch = false
vim.o.incsearch = true

-- undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"

-- others
vim.o.updatetime = 50
vim.o.termguicolors = true
vim.o.guicursor = "a:block"
vim.o.clipboard = "unnamedplus"
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})
