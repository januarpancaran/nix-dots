{
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    ../../theme
    ../../user/app/git
    ../../user/app/nvf
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/zsh.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {EDITOR = "nvim";};
  };

  home.packages = with pkgs; [
    bat
    curl
    devbox
    fzf
    glib
    htop
    ripgrep
    tree
    unrar
    unzip
    wl-clipboard
    wget
    yazi
    zip
    zoxide
  ];

  programs.home-manager.enable = true;
}
