{ pkgs, ... }:
{
  imports = [
    ./extensions
    ./settings
    ./mkMutable.nix
  ];

  programs.vscode = {
    package = pkgs.vscode;
    enable = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
    };
  };
}
