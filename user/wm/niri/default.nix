{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    polkit_gnome
    wl-mirror
  ];

  imports = [
    ./autostart
    ./binds
    ./env
    ./inputs
    ./outputs
  ];

  wayland.windowManager.niri = {
    package = pkgs.niri;
    enable = true;

    settings = {
      layout = {
        gaps = 8;
        center-focused-column = "never";

        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width.proportion = 0.5;

        focus-ring.off = { };

        border = {
          on = { };
          width = 3;
          active-color = "#c4a7e7";
          inactive-color = "#403d52";
          urgent-color = "#eb6f92";
        };
      };

      hotkey-overlay.skip-at-startup = { };
      prefer-no-csd = { };
      screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S.png";

      window-rule._children = [
        {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
        }
      ];

      cursor = {
        xcursor-theme = "Elaina";
        xcursor-size = 32;
      };
    };
  };
}
