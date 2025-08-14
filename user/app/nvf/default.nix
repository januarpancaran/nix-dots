{
  imports = [
    ./config/options.nix
    ./config/remaps.nix
    ./plugins/gitsigns.nix
    ./plugins/indent-blankline.nix
    ./plugins/lsp-config.nix
    ./plugins/markdown-preview.nix
    ./plugins/nvim-cmp.nix
    ./plugins/vim-tmux-navigator.nix
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

      vim.dashboard.alpha.enable = true;
      vim.comments.comment-nvim.enable = true;
      vim.telescope.enable = true;
    };
  };
}
