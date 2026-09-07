{
  wayland.windowManager.hyprland.settings.monitor = [
    {
      _args = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = 1.25;
        }
      ];
    }
    {
      _args = [
        {
          output = "HDMI-A-1";
          mode = "preferred";
          mirror = "eDP-1";
          scale = 1.25;
        }
      ];
    }
  ];
}
