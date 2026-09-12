{
  lib,
  pkgs,
  userSettings,
  ...
}:
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
      zoom-us
    ]
    ++ lib.optionals userSettings.enableProgrammingPkgs [
      dbeaver-bin
      jetbrains.idea
    ];
}
