{
  programs.nvf.settings = {
    vim.git.gitsigns = {
      enable = true;
      codeActions.enable = true;
      setupOpts = {
        current_line_blame = true;
      };
    };
  };
}
