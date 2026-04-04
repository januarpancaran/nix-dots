{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    polkit_gnome
    wl-mirror
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite-stable
  ];

  imports = [
    ./autostart
    ./binds
    ./env
    ./inputs
    ./outputs
  ];

  programs.niri = {
    package = pkgs.niri-unstable;
    enable = true;

    settings = {
      layout = {
        gaps = 15;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];

        default-column-width.proportion = 0.5;

        focus-ring = {
          enable = false;
        };

        border = {
          enable = true;
          width = 3;
          active.color = "#c4a7e7";
          inactive.color = "#403d52";
          urgent.color = "#eb6f92";
        };
      };

      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S.png";

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
      ];

      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
      };

      xwayland-satellite.enable = true;
    };
  };
}
