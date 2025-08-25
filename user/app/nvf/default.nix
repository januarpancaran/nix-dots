{
  imports = [
    ./config/options.nix
    ./config/remaps.nix
    ./plugins/bufferline.nix
    ./plugins/copilot.nix
    ./plugins/gitsigns.nix
    ./plugins/indent-blankline.nix
    ./plugins/lsp-config.nix
    ./plugins/markdown-preview.nix
    ./plugins/neo-tree.nix
    ./plugins/noice.nix
    ./plugins/nvim-cmp.nix
    ./plugins/telescope.nix
    ./plugins/vim-tmux-navigator.nix
    ./plugins/which-key.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      vim.statusline.lualine = {
        enable = true;
        theme = "dracula";
      };

      vim.comments.comment-nvim.enable = true;
      vim.dashboard.alpha.enable = true;
      vim.treesitter.context.enable = true;
      vim.ui.colorizer.enable = true;
      vim.ui.noice.enable = true;
      vim.utility.oil-nvim.enable = true;
    };
  };
}
