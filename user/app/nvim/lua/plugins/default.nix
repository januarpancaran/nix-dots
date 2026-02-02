{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./packageDeps.nix
  ];

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    let
      read = file: "${builtins.readFile file}";
      none-ls-extras = pkgs.vimUtils.buildVimPlugin {
        name = "none-ls-extras-nvim";
        src = inputs.none-ls-extras-nvim;
        dependencies = [ none-ls-nvim ];
      };
    in
    [
      # Dependencies
      cmp-nvim-lsp
      cmp_luasnip
      copilot-cmp
      friendly-snippets
      luasnip
      none-ls-extras
      nvim-treesitter-context
      plenary-nvim
      rainbow-delimiters-nvim
      render-markdown-nvim
      snacks-nvim
      telescope-ui-select-nvim

      # Cmp
      {
        plugin = nvim-cmp;
        type = "lua";
        config = read ../../after/plugins/cmp.lua;
      }

      # Colorizer
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = read ../../after/plugins/colorizer.lua;
      }

      # Colorscheme
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = read ../../after/plugins/colorscheme.lua;
      }

      # Comment
      {
        plugin = comment-nvim;
        type = "lua";
        config = read ../../after/plugins/comment.lua;
      }

      # Copilot
      {
        plugin = copilot-lua;
        type = "lua";
        config = read ../../after/plugins/copilot.lua;
      }

      # Dashboard
      {
        plugin = alpha-nvim;
        type = "lua";
        config = read ../../after/plugins/dashboard.lua;
      }

      # Formatter
      {
        plugin = none-ls-nvim;
        type = "lua";
        config = read ../../after/plugins/formatter.lua;
      }

      # Git
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = read ../../after/plugins/git.lua;
      }

      # Indent
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = read ../../after/plugins/indent.lua;
      }

      # Lsp
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = read ../../after/plugins/lsp.lua;
      }

      # Lualine
      {
        plugin = lualine-nvim;
        type = "lua";
        config = read ../../after/plugins/lualine.lua;
      }

      # Markdown
      {
        plugin = markdown-preview-nvim;
        type = "lua";
        config = read ../../after/plugins/markdown.lua;
      }

      # Opencode
      {
        plugin = opencode-nvim;
        type = "lua";
        config = read ../../after/plugins/opencode.lua;
      }

      # Treesitter
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = read ../../after/plugins/treesitter.lua;
      }

      # Telescope
      {
        plugin = telescope-nvim;
        type = "lua";
        config = read ../../after/plugins/telescope.lua;
      }
    ];
}
