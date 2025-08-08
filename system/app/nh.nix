{ pkgs, systemSettings, ... }:
{
  programs.nh = {
    package = pkgs.nh;
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
    flake = systemSettings.flakeDir;
  };
}
