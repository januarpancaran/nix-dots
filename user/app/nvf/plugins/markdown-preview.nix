{ pkgs, ... }:
{
  programs.nvf.settings = {
    vim.lazy.plugins."markdown-preview.nvim" = {
      package = pkgs.vimPlugins.markdown-preview-nvim;
      lazy = true;

      cmd = [
        "MarkdownPreviewToggle"
        "MarkdownPreview"
        "MarkdownPreviewStop"
      ];

      ft = [ "markdown" ];

      keys = [
        {
          key = "<C-m>";
          mode = "n";
          action = "<cmd>MarkdownPreview<CR>";
        }
      ];
    };
  };
}
