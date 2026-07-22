{
  pkgs,
  userSettings,
  ...
}:
{
  imports = [
    ../../theme
    ../../user/app/browser/firefox
    ../../user/app/browser/google-chrome
    ../../user/app/browser/vivaldi
    ../../user/app/git
    ../../user/app/mpv
    ../../user/app/noctalia
    ../../user/app/npm
    ../../user/app/onlyoffice
    ../../user/app/terminal/ghostty.nix
    ../../user/app/vim
    ../../user/app/vscode
    ../../user/app/zed-editor
    ../../user/shell/bash.nix
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/zsh.nix
    ../../user/wm/niri
    ../../user/packages/cli.nix
    ../../user/packages/programming.nix
    ../../user/packages/ui.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
      DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
      PSHOME = "${pkgs.powershell}/lib/powershell";
      POWERSHELL_TELEMETRY_OPTOUT = "1";
    };
  };

  programs.home-manager.enable = true;
}
