if not vim.g.vscode then
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end

    null_ls.setup({
        sources = {
            -- bash
            null_ls.builtins.formatting.shfmt,

            -- c/cpp
            null_ls.builtins.formatting.clang_format,

            -- csharp
            null_ls.builtins.formatting.csharpier,

            -- css/markdown/typescript
            null_ls.builtins.formatting.prettierd,

            -- go
            null_ls.builtins.formatting.gofumpt,

            -- java
            null_ls.builtins.formatting.google_java_format,

            -- lua
            null_ls.builtins.formatting.stylua,

            -- nix
            null_ls.builtins.formatting.nixfmt,

            -- php
            null_ls.builtins.formatting.phpcsfixer,
            null_ls.builtins.formatting.blade_formatter,

            -- python
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,

            -- rust
            require("none-ls.formatting.rustfmt"),
        },

        on_attach = on_attach,
    })
end
