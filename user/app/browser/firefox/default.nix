{ config, pkgs, ... }:
{
  programs.firefox = {
    package = pkgs.firefox;
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
