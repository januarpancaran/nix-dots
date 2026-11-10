{ ... }:
{
  programs.umbriel.settings = {
    general.autostart = [
      "noctalia"
      "gsettings set org.gnome.desktop.interface gtk-theme Dracula"
      "gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark"
      "gsettings set org.gnome.desktop.interface cursor-theme Elaina"
      "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
    ];
  };
}
