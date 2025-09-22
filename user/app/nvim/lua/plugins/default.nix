{pkgs, ...}: {
  imports = [
    ./extra-packages.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; let
    read = file: "${builtins.readFile file}";
  in [
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
<<<<<<< Updated upstream
  ];
=======

    # theme
    {
        plugin = catppuccin-nvim;
        type = "lua";
        config = read ../../after/plugins/theme.lua;
    }
    ];
>>>>>>> Stashed changes
}
