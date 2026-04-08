{ pkgs, ... }:
{
  imports = [
    ./extensions
    ./settings
  ];

  programs.zed-editor = {
    package = pkgs.zed-editor;
    enable = true;
  };
}
