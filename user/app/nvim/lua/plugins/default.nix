{pkgs, ...}: {
  imports = [
    ./extra-packages.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; let
    read = file: "${builtins.readFile file}";
  in [
    # alpha
    {
      plugin = alpha-nvim;
      type = "lua";
      config = read ../../after/plugins/alpha-nvim.lua;
    }
    
    # blink-cmp
    {
      plugin = blink-cmp;
      type = "lua";
      config = read ../../after/plugins/blink-cmp.lua;
    }

    # bufferline
    {
      plugin = bufferline-nvim;
      type = "lua";
      config = read ../../after/plugins/bufferline-nvim.lua;
    }

    # comment
    {
      plugin = comment-nvim;
      type = "lua";
      config = read ../../after/plugins/comment-nvim.lua;
    }

    # copilot
    {
      plugin = copilot-lua;
      type = "lua";
      config = read ../../after/plugins/copilot.lua;
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

    # oil
    {
      plugin = oil-nvim;
      type = "lua";
      config = read ../../after/plugins/oil-nvim.lua;
    }

    # telescope
    {
      plugin = telescope-nvim;
      type = "lua";
      config = read ../../after/plugins/telescope-nvim.lua;
    }

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

    # dependencies
    blink-cmp-copilot
    friendly-snippets
    mini-icons
    nvim-web-devicons
    plenary-nvim
    telescope-ui-select-nvim
  ];
}
