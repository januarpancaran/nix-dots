{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (builtins.elem "librewolf" userSettings.enableBrowsers) {
  programs.firefox = {
    package = pkgs.librewolf;
    enable = true;
    configPath = "${config.xdg.configHome}/librewolf/librewolf";
  };
}
