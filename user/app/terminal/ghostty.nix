{pkgs, ...}: {
  programs.ghostty = {
    package = pkgs.ghostty;
    enable = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;

      window-decoration = false;
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
    };
  };
}
