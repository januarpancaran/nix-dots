{userSettings, ...}: {
  imports = [
    ../../theme
    ../../user/wm/niri
    ../../user/app/terminal/ghostty.nix
    ../../user/app/browser/google-chrome.nix
    ../../user/app/git
    ../../user/services/mako
    ../../user/services/swww.nix
    ../../user/shell/zsh.nix
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/app/fuzzel
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {EDITOR = "nvim";};
  };

  programs.home-manager.enable = true;
}
