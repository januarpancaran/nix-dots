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
  ];
}
