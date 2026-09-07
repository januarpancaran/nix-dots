{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  curve = name: definition: {
    _args = [
      name
      (lua definition)
    ];
  };
  animation = definition: { _args = [ (lua definition) ]; };
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 8;
        gaps_out = 8;
        border_size = 3;
        col.active_border = "rgba(c4a7e7ff)";
        col.inactive_border = "rgba(403d52ff)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 12;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations.enabled = true;
      dwindle = {
        force_split = 2;
        preserve_split = true;
      };
      xwayland.force_zero_scaling = true;
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };
    };

    curve = [
      (curve "easeOutQuint" ''{ type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } }'')
      (curve "easeInOutCubic" ''{ type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } }'')
      (curve "linear" ''{ type = "bezier", points = { { 0, 0 }, { 1, 1 } } }'')
      (curve "almostLinear" ''{ type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } }'')
      (curve "quick" ''{ type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } }'')
      (curve "easy" ''{ type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 }'')
    ];

    animation = map animation [
      ''{ leaf = "global", enabled = true, speed = 10, bezier = "default" }''
      ''{ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" }''
      ''{ leaf = "windows", enabled = true, speed = 2, spring = "easy" }''
      ''{ leaf = "windowsIn", enabled = true, speed = 1.5, spring = "easy", style = "popin 87%" }''
      ''{ leaf = "windowsOut", enabled = true, speed = 1.5, spring = "easy", style = "popin 87%" }''
      ''{ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" }''
      ''{ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" }''
      ''{ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" }''
      ''{ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" }''
      ''{ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" }''
      ''{ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" }''
      ''{ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" }''
      ''{ leaf = "fadeLayersOut", enabled = true, speed = 1.46, bezier = "almostLinear" }''
      ''{ leaf = "workspaces", enabled = true, speed = 2, bezier = "almostLinear", style = "fade" }''
      ''{ leaf = "workspacesIn", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" }''
      ''{ leaf = "workspacesOut", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" }''
      ''{ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" }''
    ];
  };
}
