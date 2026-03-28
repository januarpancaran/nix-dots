{ pkgs, ... }:
{
  imports = [ ./style.nix ];

  programs.waybar = {
    package = pkgs.waybar;
    enable = true;

    settings = [
      {
        height = 40;
        margin = "10 20 0 20";
        spacing = 4;
        modules-left = [
          "custom/power"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "backlight"
          "battery"
          "tray"
        ];

        # Left Modules
        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "wlogout";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{class}";
          separate-outputs = false;
          icon = true;
          icon-size = 20;
          rewrite = {
            "" = " hyprland";
          };
        };

        # Center Module
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%a, %d %b, %I:%M %p}";
        };

        # Right Modules
        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} 󰂰 {format_source}";
          format-bluetooth-muted = " {icon} 󰂲 {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            "headphone" = "󰋋";
            "hands-free" = "󰋋";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ " " ];
          };
          on-click = "pavucontrol";
          min-length = 13;
          max-volume = 150;
        };

        "bluetooth" = {
          format = "󰂰";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱";
          tooltip-format = "bluetooth: {status}";
          tooltip-format-disabled = "Bluetooth Disabled";
          tooltip-format-connected = "{device_alias}";
          tooltip-format-connected-battery = "{device_alias}: {device_battery_percentage}%";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias}: {device_battery_percentage}%";
          on-click = "blueman";
          min-length = 2;
        };

        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "󰈀";
          tooltip-format = "{essid}";
          format-linked = "{ifname} (No IP) 󰈀";
          format-disconnected = "Disconnected ⚠";
          on-click = "ghostty -e nmtui";
          min-length = 2;
        };

        "backlight" = {
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "battery" = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      }
    ];
  };
}
