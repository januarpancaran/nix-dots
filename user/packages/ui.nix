{ lib, pkgs, userSettings, ... }:
{
  home.packages =
    with pkgs;
    [
      blanket
      brightnessctl
      discord
      foliate
      gnome-control-center
      gnome-solanum
      loupe
      nautilus
      obs-studio
      papers
      spotify
      telegram-desktop
      zotero
    ]
    ++ lib.optionals userSettings.enableProgrammingPkgs [
      dbeaver-bin
      google-antigravity
      jetbrains.idea
      jetbrains.jdk
    ];
}
