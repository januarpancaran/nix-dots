{
  lib,
  userSettings,
  ...
}:
{
  wayland.windowManager.niri.settings.binds =
    let
      # Simple action with no args: { action = {}; }
      bind = key: action: {
        "Mod+${key}"."${action}" = { };
      };

      # Action with a single value arg
      bindVal = key: action: val: {
        "Mod+${key}"."${action}" = val;
      };

      # Action with a prop
      bindProp = key: action: prop: val: {
        "Mod+${key}"."${action}"._props."${prop}" = val;
      };

      # Bind with a top-level prop + simple action
      bindWithProp = key: prop: propVal: action: {
        "Mod+${key}" = {
          _props."${prop}" = propVal;
          "${action}" = { };
        };
      };

      # Spawn a list of args
      bindSpawn = key: cmd: {
        "Mod+${key}".spawn = if builtins.isList cmd then cmd else [ cmd ];
      };

      # Spawn with a top-level prop
      bindSpawnProp = key: prop: propVal: cmd: {
        "Mod+${key}" = {
          _props."${prop}" = propVal;
          spawn = if builtins.isList cmd then cmd else [ cmd ];
        };
      };

      # Bare key (no Mod) + prop + spawn
      bindBareProp = key: prop: propVal: cmd: {
        "${key}" = {
          _props."${prop}" = propVal;
          spawn = if builtins.isList cmd then cmd else [ cmd ];
        };
      };

      # Bare key (no Mod) + prop + simple action
      bindBareWithProp = key: prop: propVal: action: {
        "${key}" = {
          _props."${prop}" = propVal;
          "${action}" = { };
        };
      };

      # Spawn-sh bare (no Mod) + prop
      bindSpawnShBareProp = key: prop: propVal: cmd: {
        "Mod+${key}" = {
          _props."${prop}" = propVal;
          spawn-sh = cmd;
        };
      };

      bindList = [
        # Programs
        (bindSpawn "T" "ghostty")
        (bindSpawn "B" (
          if userSettings.defaultBrowser == "google-chrome" then
            "google-chrome-stable"
          else
            userSettings.defaultBrowser
        ))
        (bindSpawn "I" (
          if userSettings.defaultBrowser == "google-chrome" then
            [
              "google-chrome-stable"
              "--incognito"
            ]
          else if userSettings.defaultBrowser == "firefox" then
            [
              "firefox"
              "--private-window"
            ]
          else
            [
              userSettings.defaultBrowser
              "--incognito"
            ]
        ))
        (bindSpawn "E" "nautilus")
        (bindSpawn "C" "zeditor")
        (bindSpawn "Shift+C" [
          "env"
          "XDG_CURRENT_DESKTOP=gnome"
          "gnome-control-center"
        ])
        (bindSpawn "SemiColon" [
          "env"
          "-u"
          "DISPLAY"
          "spotify"
          "--enable-wayland-ime"
        ])
        (bindSpawn "D" "discord")
        (bindSpawnShBareProp "Shift+SemiColon" "repeat" false
          "wl-mirror $(niri msg --json focused-output | jq -r .name)"
        )

        # Noctalia
        (bindSpawn "R" [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ])
        (bindSpawn "S" [
          "noctalia-shell"
          "ipc"
          "call"
          "controlCenter"
          "toggle"
        ])
        (bindSpawn "Comma" [
          "noctalia-shell"
          "ipc"
          "call"
          "settings"
          "toggle"
        ])

        # Volumes
        (bindBareProp "XF86AudioRaiseVolume" "allow-when-locked" true [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "increase"
        ])
        (bindBareProp "XF86AudioLowerVolume" "allow-when-locked" true [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "decrease"
        ])
        (bindBareProp "XF86AudioMute" "allow-when-locked" true [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteOutput"
        ])

        # Brightness
        (bindBareProp "XF86MonBrightnessUp" "allow-when-locked" true [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "increase"
        ])
        (bindBareProp "XF86MonBrightnessDown" "allow-when-locked" true [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "decrease"
        ])

        (bindBareWithProp "Mod+O" "repeat" false "toggle-overview")

        # Window/Workspace Management
        (bind "Q" "close-window")

        (bind "H" "focus-column-left")
        (bind "L" "focus-column-right")

        (bind "Shift+H" "move-column-left")
        (bind "Shift+L" "move-column-right")

        (bind "J" "focus-window-or-workspace-down")
        (bind "K" "focus-window-or-workspace-up")

        (bind "Shift+J" "move-window-down-or-to-workspace-down")
        (bind "Shift+K" "move-window-up-or-to-workspace-up")

        (bind "Home" "focus-column-first")
        (bind "End" "focus-column-last")

        (bind "Ctrl+Home" "move-column-to-first")
        (bind "Ctrl+End" "move-column-to-last")

        (bind "Ctrl+H" "focus-monitor-left")
        (bind "Ctrl+L" "focus-monitor-right")
        (bind "Ctrl+J" "focus-monitor-down")
        (bind "Ctrl+K" "focus-monitor-up")

        (bind "Shift+Ctrl+H" "move-column-to-monitor-left")
        (bind "Shift+Ctrl+L" "move-column-to-monitor-right")
        (bind "Shift+Ctrl+J" "move-column-to-monitor-down")
        (bind "Shift+Ctrl+K" "move-column-to-monitor-up")

        (bind "Shift+U" "move-workspace-down")
        (bind "Shift+I" "move-workspace-up")

        (bindBareWithProp "Mod+WheelScrollDown" "cooldown-ms" 150 "focus-workspace-down")
        (bindBareWithProp "Mod+WheelScrollUp" "cooldown-ms" 150 "focus-workspace-up")
        (bindBareWithProp "Mod+Ctrl+WheelScrollDown" "cooldown-ms" 150 "move-column-to-workspace-down")
        (bindBareWithProp "Mod+Ctrl+WheelScrollUp" "cooldown-ms" 150 "move-column-to-workspace-up")

        (bind "WheelScrollRight" "focus-column-right")
        (bind "WheelScrollLeft" "focus-column-left")
        (bind "Ctrl+WheelScrollRight" "move-column-right")
        (bind "Ctrl+WheelScrollLeft" "move-column-left")

        (bind "Shift+WheelScrollDown" "focus-column-right")
        (bind "Shift+WheelScrollUp" "focus-column-right")
        (bind "Ctrl+Shift+WheelScrollDown" "move-column-right")
        (bind "Ctrl+Shift+WheelScrollUp" "move-column-left")

        (bind "BracketLeft" "consume-or-expel-window-left")
        (bind "BracketRight" "consume-or-expel-window-right")
        (bind "Period" "expel-window-from-column")

        (bind "Ctrl+W" "switch-preset-column-width")
        (bind "Ctrl+S" "switch-preset-window-height")
        (bind "Ctrl+R" "reset-window-height")

        (bind "F" "maximize-column")
        (bind "Shift+F" "fullscreen-window")
        (bind "Ctrl+F" "expand-column-to-available-width")
        (bind "Ctrl+C" "center-visible-columns")

        (bindVal "Minus" "set-column-width" "-10%")
        (bindVal "Equal" "set-column-width" "+10%")
        (bindVal "Shift+Minus" "set-window-height" "-10%")
        (bindVal "Shift+Equal" "set-window-height" "+10%")

        (bind "V" "toggle-window-floating")
        (bind "Shift+V" "switch-focus-between-floating-and-tiling")
        (bind "W" "toggle-column-tabbed-display")

        (bindProp "Shift+S" "screenshot" "show-pointer" false)
        (bindProp "Shift+P" "screenshot-screen" "write-to-disk" true)
        (bindProp "P" "screenshot-window" "write-to-disk" true)

        (bindBareWithProp "Mod+Escape" "allow-inhibiting" false "toggle-keyboard-shortcuts-inhibit")

        (bindProp "Shift+M" "quit" "skip-confirmation" true)
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            idx = i + 1;
          in
          [
            (bindVal "${toString idx}" "focus-workspace" idx)
            (bindVal "Shift+${toString idx}" "move-column-to-workspace" idx)
          ]
        ) 9
      ));
    in
    lib.foldl' lib.recursiveUpdate { } bindList;
}
