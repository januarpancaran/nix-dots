{ pkgs, ... }:
{
  home.file.".config/dunst/icons" = {
    source = ./icons;
    recursive = true;
  };

  services.dunst = {
    package = pkgs.dunst;
    enable = true;

    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(400, 400)";
        height = "(100, 100)";
        origin = "top-right";
        offset = "(0, 25)";
        scale = 0;
        notification_limit = 0;

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 400;
        progress_bar_corner_radius = 0;
        progress_bar_corners = "all";

        icon_corner_radius = 0;
        icon_corners = "all";
        indicate_hidden = "yes";

        transparency = 0;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 14;
        text_icon_padding = 20;

        frame_width = 3;
        frame_color = "#aaaaaa";

        gap_size = 0;
        separator_color = "frame";
        sort = "yes";

        font = "SpaceMono Nerd Font 14";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";

        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";

        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";

        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 50;
        icon_path = "$HOME/.config/dunst/icons/";

        sticky_history = "yes";
        history_length = 20;

        dmenu = "/usr/bin/dmenu -p dunst";
        browser = "/usr/bin/xdg-open";

        always_run_script = true;
        title = "Dunst";
        class = "Dunst";

        corner_radius = 12;
        corners = "all";

        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      experimental = {
        per_monitor_dpi = false;
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#cba6f7";
        timeout = 10;
        default_icon = "$HOME/.config/dunst/icons/bell.png";
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#cba6f7";
        timeout = 10;
        default_icon = "$HOME/.config/dunst/icons/bell.png";
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#ff0000";
        timeout = 0;
        default_icon = "$HOME/.config/dunst/icons/bell.png";
      };

      history-ignore = {
        appname = "changevolume";
        history_ignore = "yes";
      };
    };
  };
}
