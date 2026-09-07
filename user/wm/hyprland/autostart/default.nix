{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland.settings.on = {
    _args = [
      "hyprland.start"
      (lua ''function()
        hl.exec_cmd("fcitx5 -d -r")
        hl.exec_cmd("fcitx5-remote -d -r")
        hl.exec_cmd("noctalia --daemon")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Dracula")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Elaina")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
      end'')
    ];
  };
}
