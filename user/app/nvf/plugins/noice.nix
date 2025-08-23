{
  programs.nvf.settings.vim.ui.noice = {
    enable = true;

    setupOpts = {
      routes = [
        {
          filter = {
            event = "lsp";
            kind = "progress";
          };
          opts = {
            throttle = 1000;
            merge = true;
          };
        }
      ];
    };
  };
}
