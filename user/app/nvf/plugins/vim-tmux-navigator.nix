{pkgs, ...}: {
  programs.nvf.settings = {
    vim.lazy.plugins."vim-tmux-navigator" = {
      package = pkgs.vimPlugins.vim-tmux-navigator;
      lazy = true;

      cmd = [
        "TmuxNavigateLeft"
        "TmuxNavigateDown"
        "TmuxNavigateUp"
        "TmuxNavigateRight"
        "TmuxNavigatePrevious"
        "TmuxNavigatorProcessList"
      ];

      keys = [
        {
          key = "<C-h>";
          mode = "n";
          action = "<cmd><C-U>TmuxNavigateLeft<CR>";
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<cmd><C-U>TmuxNavigateDown<CR>";
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<cmd><C-U>TmuxNavigateUp<CR>";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<cmd><C-U>TmuxNavigateRight<CR>";
        }
        {
          key = "<C-\\\\>";
          mode = "n";
          action = "<cmd><C-U>TmuxNavigatePrevious<CR>";
        }
      ];
    };
  };
}
