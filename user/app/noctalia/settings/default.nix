{ userSettings, ... }:
{
  programs.noctalia.settings = {
    theme = {
      mode = "dark";
      source = "builtin";
      builtin = "Rosé Pine";
    };

    audio = {
      enable_overdrive = true;
    };

    shell = {
      panel = {
        launcher_placement = "attached";
      };
      font_family = "Sans Serif";
      corner_radius_scale = 1.0;
      button_borders = true;
      card_borders = true;
      popup_borders = true;
      popup_shadows = true;
      telemetry_enabled = false;
      clipboard_enabled = false;
      launch_apps_as_systemd_services = false;
    };

    bar = {
      default = {
        position = "top";
        thickness = 36;
        background_opacity = 0.93;
        margin_ends = 0;
        margin_edge = 0;
        reserve_space = true;
        radius = 0;
        padding = 12;
        widget_spacing = 8;
        capsule = true;
        capsule_fill = "surface_variant";
        capsule_foreground = "on_surface";
        color = "on_surface";
        capsule_border = "outline";
        capsule_opacity = 0.86;
        show_on_workspace_switch = true;
        start = [
          "launcher"
          "workspaces"
          "active-window"
        ];
        center = [ "clock" ];
        end = [
          "volume"
          "brightness"
          "network"
          "battery"
          "control-center"
        ];
      };
    };

    widget = {
      clock = {
        format = "{:%H:%M}";
        tooltip_format = "{:%A, %B %d, %Y}";
        font_weight = 600;
        capsule = true;
      };

      launcher = {
        glyph = "rocket";
      };

      workspaces = {
        style = "minimal";
        show_labels = true;
        label_source = "id";
        max_label_chars = 1;
      };

      "active-window" = {
        type = "active_window";
        min_length = 80;
        max_length = 220;
        display = "icon_and_text";
        title_scroll = "on_hover";
        capsule = false;
      };

      media = {
        max_length = 180;
        hide_when_no_media = true;
        title_scroll = "on_hover";
      };

      volume = {
        show_label = true;
      };

      brightness = {
        show_label = false;
      };

      network = {
        show_label = false;
      };

      bluetooth = {
        show_label = false;
        hide_when_no_connected_device = true;
      };

      "control-center" = {
        glyph = "home";
      };

    };

    wallpaper = {
      enabled = true;
      directory = "/home/${userSettings.username}/Pictures/Wallpapers";
      fill_mode = "crop";
      transition_duration = 1500;
    };
  };
}
