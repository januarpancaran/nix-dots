{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        name = "suppress-maximize-events";
        match.class = ".*";
        suppress_event = "maximize";
      }
      {
        name = "fix-xwayland-drags";
        match = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        no_focus = true;
      }
      {
        name = "steam-game-suppress-activate";
        match.class = "^steam_app_.*$";
        render_unfocused = true;
        idle_inhibit = "always";
        suppress_event = "activate";
      }
    ];
  };
}
