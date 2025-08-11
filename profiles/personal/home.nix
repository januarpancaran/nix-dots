{userSettings, ...}: {
  imports = [
    ../../theme
    ../../user/app/browser/google-chrome.nix
    ../../user/app/fuzzel
    ../../user/app/git
    ../../user/app/hyprlock
    ../../user/app/mpv
    ../../user/app/terminal/ghostty.nix
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
    ../../user/shell/zsh.nix
    ../../user/wm/niri
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {EDITOR = "nvim";};
  };

  programs.home-manager.enable = true;
}
