{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings = {
    vim.lineNumberMode = "relNumber";
    vim.options = {
      signcolumn = "yes";
      wrap = true;

      tabstop = 2;
      shiftwidth = 2;

      autoindent = true;

      updatetime = 50;
      termguicolors = true;
    };

    vim.clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };

    vim.undoFile = {
      enable = true;
      path = mkLuaInline "os.getenv('HOME') .. '/.vim/undodir'";
    };

    vim.hideSearchHighlight = true;
    vim.diagnostics = {
      enable = true;

      config = {
        virtual_text = true;
        signs = true;
        underline = true;
        update_in_insert = true;
      };
    };
  };
}
