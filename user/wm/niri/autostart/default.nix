{pkgs, ...}: {
  programs.niri.settings.spawn-at-startup =
    map (exe: {
      command = pkgs.lib.strings.splitString " " exe;
    }) [
      "mako"
      "eww daemon"
      "eww open bar"
      "hypridle"
      "gsettings set org.gnome.desktop.interface gtk-theme Dracula"
      "gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark"
      "gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic"
      "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
    ];
}
