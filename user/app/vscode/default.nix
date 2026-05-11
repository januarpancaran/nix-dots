{ pkgs, ... }:
{
  imports = [
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };
}
