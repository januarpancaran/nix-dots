{
  programs.nvf.settings = {
    vim.tabline.nvimBufferline = {
      enable = true;

      mappings = {
        closeCurrent = "<leader>bw";
        cycleNext = "<leader>bn";
        cyclePrevious = "<leader>bp";
        moveNext = "<leader>bmn";
        movePrevious = "<leader>bmp";
        pick = "<leader>bc";
        sortByDirectory = "<leader>bsd";
        sortByExtension = "<leader>bse";
        sortById = "<leader>bsi";
      };
    };
  };
}
