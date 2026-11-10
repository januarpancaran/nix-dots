{ ... }:
{
  programs.umbriel.settings = {
    window_rule = [
      { corner_radius = 12; }
      { blur = true; }
      {
        match.app_id = "^obs$";
        background_render = true;
      }
      {
        match.app_id = "^steam_app_.*$";
        confine_pointer = true;
        background_render = true;
      }
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1020;
          height = 900;
        };
      }
      {
        match.app_id = "^dev.noctalia.UmbrielSharePicker$";
        default_floating = true;
        default_floating_size_px = {
          width = 800;
          height = 600;
        };
      }
      {
        match.title = "^(Picture-in-Picture|Picture in picture)$";
        default_floating = true;
        default_maximize = false;
        default_position = {
          x = 20;
          y = 20;
          anchor = "bottom_right";
        };
      }
      {
        match.title = "^notificationtoasts_.+_desktop";
        default_position = {
          x = 0;
          y = 0;
          anchor = "bottom_right";
        };
        default_focused = false;
        default_pinned = true;
      }
    ];

    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_popups = true;
      }
      {
        match.namespace = "^noctalia-(notification|dock|panel|attached-panel|osd)$";
        blur_optimized = false;
      }
    ];
  };
}
