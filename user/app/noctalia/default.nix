{ pkgs, ... }:
{
  imports = [
    ./settings
    ./plugins
    ./screen-mirror.nix
  ];

  programs.noctalia = {
    enable = true;
    package = pkgs.noctalia;
  };
}
