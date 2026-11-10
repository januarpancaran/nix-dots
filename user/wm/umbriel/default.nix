{ inputs, pkgs, ... }:
{
  imports = [
    ./settings
  ];

  programs.umbriel.enable = true;
}
