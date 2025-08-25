{
  programs.nvf.settings = {
    vim.binds.whichKey = {
      enable = true;

      register = {
        # Oil
        "<leader>p" = "Oil";
        "<leader>pp" = "Exit";

        # Neotree
        "<leader>n" = "Neotree";
        "<leader>ne" = "Neotree Toggle";

        # LSP
        "<leader>K" = "Trigger Hover";
        "<leader>gd" = "Go To Definition";
        "<leader>ca" = "Code Action";
        "<leader>gf" = "Format";

        # Bufferline
        "<leader>b" = "Bufferline";
        "<leader>bw" = "Close Buffer";
        "<leader>bn" = "Next Buffer";
        "<leader>bp" = "Previous Buffer";
        "<leader>bm" = "Move Buffer";
        "<leader>bmn" = "Move Next Buffer";
        "<leader>bmp" = "Move Previous Buffer";
        "<leader>bc" = "Pick Buffer";
        "<leader>bs" = "Sort Buffers";
        "<leader>bsd" = "Sort Buffers by Directory";
        "<leader>bse" = "Sort Buffers by Extension";
        "<leader>bsi" = "Sort Buffers by ID";

        # Telescope
        "<leader>ff" = "Find File";
        "<leader>fg" = "Live Grep";
      };
    };
  };
}
