{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (builtins.elem "firefox" userSettings.enableBrowsers) {
  programs.firefox = {
    package = pkgs.firefox;
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

  };
}
