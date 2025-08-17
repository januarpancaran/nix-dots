{pkgs, ...}: {
  home.packages = with pkgs; [
    brightnessctl
    ghostty
    nautilus
    polkit_gnome
    wireplumber
    wl-clipboard
  ];

  imports = [
    ./autostart
    ./binds
    ./env
    ./inputs
    ./outputs
  ];

  programs.niri = {
    package = pkgs.niri-stable;
    enable = true;

    settings = {
      layout = {
        gaps = 8;
        center-focused-column = "never";

        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];

        default-column-width.proportion = 0.5;

        border = {
          enable = true;
          width = 4;
          active.color = "#cba6f7";
          inactive.color = "#595959";
          urgent.color = "#9b0000";
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
