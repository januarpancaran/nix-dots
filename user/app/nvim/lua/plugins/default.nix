{pkgs, ...}: {
  imports = [
    ./extra-packages.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; let
    read = file: "${builtins.readFile file}";
  in [
    {
      plugin = alpha-nvim;
      type = "lua";
      config = read ../../after/plugins/alpha-nvim.lua;
    }

    {
      plugin = comment-nvim;
      type = "lua";
      config = read ../../after/plugins/comment-nvim.lua;
    }

    # lsp
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = read ../../after/plugins/lspconfig-nvim.lua;
    }

    # lualine
    {
      plugin = lualine-nvim;
      type = "lua";
      config = read ../../after/plugins/lualine-nvim.lua;
    }
    nvim-web-devicons

    # treesitter
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = read ../../after/plugins/nvim-treesitter.lua;
    }
    {
      plugin = nvim-treesitter-context;
      type = "lua";
      config = read ../../after/plugins/nvim-treesitter-context.lua;
    }

    # theme
    {
      plugin = catppuccin-nvim;
      type = "lua";
      config = read ../../after/plugins/theme.lua;
    }
  ];
}
