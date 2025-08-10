{pkgs, ...}: {
  home.packages = with pkgs; [
    acpi
  ];

  systemd.user.services = let
    waylandDisplay = "wayland-0";
    dbus = "unix:path=/run/user/1000/bus";

    batteryNotifier = pkgs.writeShellScriptBin "battery-notifier" ''
      #!/usr/bin/env bash

      ICON_DIR="$HOME/.config/mako/icons";

      export WAYLAND_DISPLAY=${waylandDisplay}
      export DBUS_SESSION_BUS_ADDRESS=${dbus}

      WARNING_LEVEL=20
      BATTERY_DISCHARGING=$(acpi -b | grep -c "Discharging")
      BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

      EMPTY_FILE="/tmp/batteryempty"
      FULL_FILE="/tmp/batteryfull"

      if [ "$BATTERY_DISCHARGING" -eq 1 ] && [ -f "$FULL_FILE" ]; then
        rm $FULL_FILE
      elif [ "$BATTERY_DISCHARGING" -eq 0 ] && [ -f "$EMPTY_FILE" ]; then
        rm $EMPTY_FILE
      fi

      if [ "$BATTERY_LEVEL" -gt 98 ] && [ "$BATTERY_DISCHARGING" -eq 0 ] && [ ! -f "$FULL_FILE" ]; then
        notify-send "Battery Charged" "Battery is fully charged." -i "$ICON_DIR/battery.png" -r 9991
        touch $FULL_FILE
      elif [ "$BATTERY_LEVEL" -le "$WARNING_LEVEL" ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f "$EMPTY_FILE" ]; then
        notify-send "Low Battery" "$BATTERY_LEVEL% of battery remaining." -u critical -i "$ICON_DIR/battery-low.png"
        touch $EMPTY_FILE
      fi
    '';
  in {
    battery-notify = {
      Unit = {
        Description = "Battery notification service";
      };

      Service = {
        ExecStart = "${batteryNotifier}/bin/battery-notifier";
      };
    };

    trash-empty = {
      Unit = {
        Description = "Empty trash older than 30 days";
      };

      Service = {
        ExecStart = "/sbin/trash-empty 30";
      };
    };
  };
}
