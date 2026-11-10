{ pkgs, ... }:
{
  imports = [
    ./settings
    ./plugins
  ];

  programs.noctalia = {
    enable = true;
    package = pkgs.noctalia;
  };
}
