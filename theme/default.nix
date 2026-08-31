{ pkgs, ... }:
let
  elainaCursorTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "elaina-cursor-theme";
    version = "1.0";
    src = ./cursors/elaina;
    dontBuild = true;
    installPhase = ''
      install -dm755 $out/share/icons/Elaina
      cp -r ./* $out/share/icons/Elaina/
    '';
  };
in
{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    gtk4.theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-nord-dark";
    };

    cursorTheme = {
      package = elainaCursorTheme;
      name = "Elaina";
      size = 32;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Catppuccin
  catppuccin =
    let
      default = {
        enable = true;
        flavor = "mocha";
      };
    in
    {
      enable = true;
      # Disable all supported programs by default and only apply to specified packages
      autoEnable = false;

      bat = default;

      fzf = default;

      tmux = default // {
        extraConfig = ''
          set -g @catppuccin_window_status_style "rounded"
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_session}"
        '';
      };
    };
}
