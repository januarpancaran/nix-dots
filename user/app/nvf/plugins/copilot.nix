{
  programs.nvf.settings = {
    vim.assistant.copilot = {
      enable = true;
      cmp.enable = true;

      mappings = {
        suggestion = {
          accept = "<C-f>";
          acceptWord = "<C-j>";
          dismiss = "<C-]>";
        };
      };
    };
  };
}
