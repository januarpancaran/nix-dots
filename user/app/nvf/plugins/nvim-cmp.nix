{
  programs.nvf.settings = {
    vim.autocomplete.nvim-cmp = {
      enable = true;

      sourcePlugins = [
        "cmp-nvim-lsp"
        "luasnip"
        "cmp-luasnip"
        "friendly-snippets"
      ];

      sources = {
        nvim_lsp = "[LSP]";
        luasnip = "[Snippet]";
        buffer = "[Buffer]";
      };

      mappings = {
        complete = "<C-Space>";
        confirm = "<CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
        scrollDocsDown = "<C-f>";
        scrollDocsUp = "<C-d>";
      };
    };

    vim.ui.borders.plugins.nvim-cmp = {
      enable = true;
      style = "rounded";
    };
  };
}
