{
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    ../../theme
    ../../user/app/git
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/bash.nix
    ../../user/shell/zsh.nix

    (
      if userSettings.nvimFlavour == "nvf"
      then ../../user/app/nvf
      else ../../user/app/nvim
    )
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
