{ ... }:
{
  programs.umbriel.settings = {
    general.autostart = [
    "fcitx5 -d -r"
    "fcitx5-remote -d -r"
      "noctalia --daemon"
      "gsettings set org.gnome.desktop.interface gtk-theme Dracula"
      "gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark"
      "gsettings set org.gnome.desktop.interface cursor-theme Elaina"
      "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
    ];
  };
}
