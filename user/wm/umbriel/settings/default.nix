{ ... }:
{
  imports = [
    ./appearance.nix
    ./autostart.nix
    ./binds.nix
    ./env.nix
    ./inputs.nix
    ./outputs.nix
    ./rules.nix
  ];

  programs.umbriel.settings = {
    general = {
      mod_key = "Super";
      xwayland = true;
      xwayland_native_resolution = true;
      show_cheatsheet = false;
    };

    events = {
      lid_close = "umbriel msg output-disable eDP-1";
      lid_open = "umbriel msg output-enable eDP-1";
    };

    hot_corners.top_left = {
      enabled = true;
      delay_ms = 500;
      action = "overview-open";
    };
  };
}
