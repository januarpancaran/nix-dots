{
  pkgs,
  inputs,
  ...
}: {
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

    # colorizer
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = read ../../after/plugins/nvim-colorizer.lua;
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

    # docs-view
    {
      plugin = nvim-docs-view;
      type = "lua";
      config = read ../../after/plugins/nvim-docs-view.lua;
    }

    # gitsigns
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = read ../../after/plugins/gitsigns-nvim.lua;
    }

    # indent-blankline
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config = read ../../after/plugins/indent-blankline-nvim.lua;
    }

    # lightbulb
    {
      plugin = nvim-lightbulb;
      type = "lua";
      config = read ../../after/plugins/nvim-lightbulb.lua;
    }

    # lsp
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = read ../../after/plugins/lspconfig-nvim.lua;
    }

    # lspsaga
    {
      plugin = lspsaga-nvim;
      type = "lua";
      config = read ../../after/plugins/lspsaga-nvim.lua;
    }

    # lualine
    {
      plugin = lualine-nvim;
      type = "lua";
      config = read ../../after/plugins/lualine-nvim.lua;
    }

    # markdown preview
    {
      plugin = markdown-preview-nvim;
      type = "lua";
      config = read ../../after/plugins/markdown-preview-nvim.lua;
    }

    # noice
    {
      plugin = noice-nvim;
      type = "lua";
      config = read ../../after/plugins/noice-nvim.lua;
    }

    # none-ls
    {
      plugin = none-ls-nvim;
      type = "lua";
      config = read ../../after/plugins/none-ls-nvim.lua;
    }
    (pkgs.vimUtils.buildVimPlugin {
      name = "none-ls-extras-nvim";
      src = inputs.none-ls-extras-nvim;
      dependencies = [none-ls-nvim];
    })

    # oil
    {
      plugin = oil-nvim;
      type = "lua";
      config = read ../../after/plugins/oil-nvim.lua;
    }

    # rainbow delimiters
    {
      plugin = rainbow-delimiters-nvim;
      type = "lua";
      config = read ../../after/plugins/rainbow-delimiters-nvim.lua;
    }

    # render markdown
    {
      plugin = render-markdown-nvim;
      type = "lua";
      config = read ../../after/plugins/render-markdown-nvim.lua;
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
    copilot-lsp
    friendly-snippets
    mini-icons
    mini-nvim
    nui-nvim
    nvim-notify
    nvim-web-devicons
    plenary-nvim
    telescope-ui-select-nvim
  ];
}
