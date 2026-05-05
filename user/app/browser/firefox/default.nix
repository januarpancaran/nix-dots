{ config, pkgs, ... }:
{
  imports = [
    ./policies.nix
    ./profiles.nix
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
