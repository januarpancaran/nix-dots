{
  pkgs,
  userSettings,
  ...
}: {
  services.hypridle = {
    package = pkgs.hypridle;
    enable = true;

    settings = let
      monitor = "eDP-1";
    in {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd =
          if userSettings.wm == "niri"
          then "niri msg output ${monitor} on"
          else "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout =
            if userSettings.wm == "niri"
            then "niri msg output ${monitor} off"
            else "hyprctl dispatch dpms off";
          on-resume =
            if userSettings.wm == "niri"
            then "niri msg output ${monitor} on"
            else "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
