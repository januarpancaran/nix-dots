{pkgs, ...}: let
  volumeNotifier = pkgs.writeShellScriptBin "volume-notifier" ''
    #!/usr/bin/env bash

    ICON_DIR="$HOME/.config/dunst/icons"

    function send_notification() {
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
      notify-send -a "changevolume" -u low -r 9993 -h int:value:"$VOLUME" -i "$1" "Volume: $VOLUME%" -t 2000
    }

    case $1 in
    up)
      wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+
      send_notification "$ICON_DIR/volume-change.png"
      ;;
    down)
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      send_notification "$ICON_DIR/volume-change.png"
      ;;
    mute)
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
        notify-send -a "changevolume" -u low -r 9993 -i "$ICON_DIR/volume-change.png" "Muted" -t 2000
      else
        send_notification "$ICON_DIR/volume-change.png"
      fi
      ;;
    esac
  '';

  brightnessNotifier = pkgs.writeShellScriptBin "brightness-notifier" ''
    #!/usr/bin/env bash

    ICON_DIR="$HOME/.config/dunst/icons"

    function send_notification() {
      BRIGHTNESS=$(brightnessctl get)
      MAX_BRIGHTNESS=$(brightnessctl max)
      PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))
      notify-send -a "changebrightness" -u low -r 9994 -h int:value:"$PERCENTAGE" -i "$ICON_DIR/brightness-change.png" "Brightness: $PERCENTAGE%" -t 2000
    }

    case $1 in
    up)
      brightnessctl set +5%
      send_notification
      ;;
    down)
      brightnessctl set 5%- --min-value=1
      send_notification
      ;;
    esac
  '';
in {
  wayland.windowManager.hyprland.settings = {
    "$terminal" = "ghostty";
    "$fileManager" = "nautilus";
    "$menu" = "rofi";
    "$browser" = "google-chrome-stable";

    "$mainMod" = "SUPER";

    bind =
      [
        # Shortcuts
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu -show drun"
        "Alt, Tab, exec, $menu -show window"
        "$mainMod, F, fullscreen"
        "$mainMod, B, exec, $browser"
        "$mainMod, I, exec, $browser --incognito"
        "$mainMod SHIFT, C, exec, env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
        "$mainMod, SemiColon, exec, spotify"
        "$mainMod, C, exec, code"
        "$mainMod, D, exec, discord"
        "$mainMod, O, exec, obs"
        "$mainMod, M, exec, wlogout"
        "$mainMod SHIFT, S, exec, hyprshot -m region -o ~/Pictures/Screenshots/ -f Screenshot_$(date +'%Y%m%d_%H%M%S').png -t 2000"
        "$mainMod, P, exec, hyprshot -m window -m active -o ~/Pictures/Screenshots/ -f Screenshot_$(date +'%Y%m%d_%H%M%S').png -t 2000"
        ", Print, exec, hyprshot -m window -m active -t 2000 --clipboard-only"
        "$mainMod SHIFT, P, exec, hyprshot -m output -m active -o ~/Pictures/Screenshots/ -f Screenshot_$(date +'%Y%m%d_%H%M%S').png -t 2000"

        # Move Focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Special Workspaces
        "$mainMod, S, togglespecialworkspace, magic"

        # Scroll Workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++ (
        # Workspaces
        builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "$mainMod, code:1${toString i}, workspace, ${toString ws}"
            "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          10)
      );

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Brightness and Volume
    bindel = [
      ", XF86AudioRaiseVolume, exec, ${volumeNotifier}/bin/volume-notifier up"
      ", XF86AudioLowerVolume, exec, ${volumeNotifier}/bin/volume-notifier down"
      ", XF86AudioMute, exec, ${volumeNotifier}/bin/volume-notifier mute"
      ", XF86MonBrightnessUp, exec, ${brightnessNotifier}/bin/brightness-notifier up"
      ", XF86MonBrightnessDown, exec, ${brightnessNotifier}/bin/brightness-notifier down"
    ];

    # Playerctl
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
