{
  programs.nvf.settings = {
    vim.globals.mapleader = " ";

    vim.keymaps = [
      {
        key = "<leader>pp";
        mode = "n";
        silent = true;
        action = "<cmd>Ex<CR>";
      }
      {
        key = "j";
        mode = "n";
        silent = true;
        action = "jzz";
      }
      {
        key = "k";
        mode = "n";
        silent = true;
        action = "kzz";
      }
      {
        key = "{";
        mode = "n";
        silent = true;
        action = "{zz";
      }
      {
        key = "}";
        mode = "n";
        silent = true;
        action = "}zz";
      }
      {
        key = "J";
        mode = "v";
        silent = true;
        action = ":m '>+1<CR>gv=gv";
      }
      {
        key = "K";
        mode = "v";
        silent = true;
        action = ":m '<-2<CR>gv=gv";
      }
      {
        key = "<C-h>";
        mode = "n";
        silent = true;
        action = "wincmd h<CR>";
      }
      {
        key = "<C-j>";
        mode = "n";
        silent = true;
        action = "wincmd j<CR>";
      }
      {
        key = "<C-k>";
        mode = "n";
        silent = true;
        action = "wincmd k<CR>";
      }
      {
        key = "<C-l>";
        mode = "n";
        silent = true;
        action = "wincmd l<CR>";
      }
    ];
  };
}
