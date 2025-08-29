{
  pkgs,
  userSettings,
  ...
}: {
  imports =
    [
      ../../theme
      ../../user/app/browser/google-chrome.nix
      ../../user/app/git
      ../../user/app/hyprlock
      ../../user/app/mpv
      ../../user/app/nvf
      ../../user/app/terminal/ghostty.nix
      ../../user/app/vscode
      ../../user/app/wlogout
      ../../user/inputs/fcitx5.nix
      ../../user/services/hypridle.nix
      ../../user/services/mako
      ../../user/services/swww.nix
      ../../user/services/systemd-services.nix
      ../../user/services/systemd-timers.nix
      ../../user/services/xdg-portal.nix
      ../../user/shell/shell-utils/fastfetch.nix
      ../../user/shell/shell-utils/starship
      ../../user/shell/shell-utils/tmux.nix
      ../../user/shell/zsh.nix
    ]
    ++ (
      if userSettings.wm == "niri"
      then [../../user/wm/niri ../../user/app/eww ../../user/app/fuzzel]
      else [../../user/wm/hyprland ../../user/app/waybar ../../user/app/rofi]
    );

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
    eog
    evince
    foliate
    fzf
    glib
    htop
    insomnia
    libreoffice
    ripgrep
    telegram-desktop
    tree
    unityhub
    unrar
    unzip
    wget
    yazi
    zip
    zotero
    zoxide
  ];

  programs.home-manager.enable = true;
}
