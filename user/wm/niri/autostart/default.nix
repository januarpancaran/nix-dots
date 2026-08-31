{ pkgs, ... }:
{
  wayland.windowManager.niri.settings._children =
    map (cmd: { spawn-at-startup._args = pkgs.lib.strings.splitString " " cmd; })
      [
        "fcitx5 -d -r"
        "fcitx5-remote -d -r"
        "noctalia-shell"
        "gsettings set org.gnome.desktop.interface gtk-theme Dracula"
        "gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark"
        "gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic"
        "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
      ];
}
