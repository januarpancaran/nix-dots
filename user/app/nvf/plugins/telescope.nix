{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings = {
    vim.lazy.plugins = {
      "telescope.nvim" = {
        package = pkgs.vimPlugins.telescope-nvim;
        keys = [
          {
            key = "<leader>ff";
            mode = "n";
            action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
          }
          {
            key = "<leader>fg";
            mode = "n";
            action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
          }
        ];

        setupModule = "telescope";
        setupOpts = {
          extensions = {
            "ui-select" = mkLuaInline "require('telescope.themes').get_dropdown({})";
          };
        };

        after = "require('telescope').load_extension('ui-select')";
      };

      "plenary.nvim" = {
        package = pkgs.vimPlugins.plenary-nvim;
      };

      "telescope-ui-select.nvim" = {
        package = pkgs.vimPlugins.telescope-ui-select-nvim;
      };
    };
  };
}
