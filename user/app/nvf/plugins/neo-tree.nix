{
  programs.nvf.settings = {
    vim.filetree.neo-tree = {
      enable = true;
      setupOpts = {
        defaut.source = "filesystem";

        filesystem = {
          hijack_netrw_behavior = "open_default";
          window = {
            position = "right";
            width = 40;
          };
        };
      };
    };
  };
}
