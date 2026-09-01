{ userSettings, ... }:
{
  programs.noctalia.settings = {
    theme = {
      mode = "dark";
      source = "builtin";
      builtin = "Rosé Pine";
    };

    shell = {
      font_family = "Sans Serif";
      telemetry_enabled = false;
      clipboard_enabled = false;
      launch_apps_as_systemd_services = false;
    };

    bar = {
      default = {
      position = "top";
      thickness = 34;
      background_opacity = 0.93;
      margin_ends = 4;
      margin_edge = 4;
      reserve_space = true;
      radius = 12;
      padding = 8;
      widget_spacing = 6;
      capsule = false;
      show_on_workspace_switch = true;
      start = [ "launcher" "workspaces" ];
      center = [ "clock" ];
      end = [
        "active-window"
        "media"
        "tray"
        "notifications"
        "volume"
        "brightness"
        "battery"
        "control-center"
      ];
      };
    };

    widget = {
      clock = {
      format = "{:%H:%M %a, %b %d}";

      tooltip_format = "{:%A, %B %d, %Y}";
      };

      launcher = {
      glyph = "rocket";
      };

      workspaces = {
      style = "minimal";
      show_labels = true;
      label_source = "id";
      };

      "active-window" = {
      max_length = 145;
      display = "icon_and_text";
      title_scroll = "on_hover";
      };

      media = {
      max_length = 145;
      hide_when_no_media = true;
      };

      volume = {
      show_label = false;
      };

      brightness = {
      show_label = false;
      };

      "control-center" = {
      glyph = "settings";
      };
    };

    wallpaper = {
      enabled = true;
      directory = "/home/${userSettings.username}/Pictures/Wallpapers";
      fill_mode = "crop";
      set_wallpaper_on_all_monitors = true;
      transition_duration = 1500;
    };

    idle = {
      enabled = true;
      lock_timeout = 330;
      screen_off_timeout = 300;
      suspend_timeout = 600;
      fade_duration = 5;
    };
  };
}
