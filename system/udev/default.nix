{
  pkgs,
  userSettings,
  ...
}: {
  environment.systemPackages = with pkgs; [
    acpi
  ];

  services.udev.extraRules = let
    waylandDisplay = "wayland-0";
    dbus = "unix:path=/run/user/1000/bus";

    chargingNotifier = pkgs.writeShellScriptBin "charging-notifier" ''
      #!/usr/bin/env bash

      ICON_DIR="$HOME/.config/mako/icons"

      export WAYLAND_DISPLAY=${waylandDisplay}
      export DBUS_SESSION_BUS_ADDRESS=${dbus}

      BATTERY_CHARGING=$1
      BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

      if [ "$BATTERY_CHARGING" -eq 1 ]; then
        notify-send "Charging" "$BATTERY_LEVEL% of battery charged." -u low -i "$ICON_DIR/battery-charging.png" -t 5000 -r 9991
      elif [ "$BATTERY_CHARGING" -eq 0 ]; then
        notify-send "Discharging" "$BATTERY_LEVEL% of battery remaining." -u low -i "$ICON_DIR/battery.png" -t 5000 -r 9991
      fi
    '';
  in ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="1", ENV{WAYLAND_DISPLAY}="${waylandDisplay}", ENV{DBUS_SESSION_BUS_ADDRESS}="${dbus}" RUN+="${pkgs.su}/bin/su ${userSettings.username} -c '${chargingNotifier}/bin/charging-notifier 1'"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="0", ENV{WAYLAND_DISPLAY}="${waylandDisplay}", ENV{DBUS_SESSION_BUS_ADDRESS}="${dbus}" RUN+="${pkgs.su}/bin/su ${userSettings.username} -c '${chargingNotifier}/bin/charging-notifier 0'"
  '';
}
