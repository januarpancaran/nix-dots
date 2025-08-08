{lib, ...}: {
  programs.niri.settings.binds = let
    inherit (lib.attrsets) setAttrByPath recursiveUpdate;

    bind = key: cmd: setAttrByPath ["Mod+${key}" "action" cmd] {};

    bindAttr = key: cmd: attr: attrVal: setAttrByPath ["Mod+${key}" "action" cmd attr] attrVal;

    bindArgs = key: args: argsVal: cmd:
      recursiveUpdate
      (setAttrByPath ["Mod+${key}" args] argsVal)
      (setAttrByPath ["Mod+${key}" "action" cmd] {});

    bindSpawn = key: cmd: setAttrByPath ["Mod+${key}" "action" "spawn"] cmd;

    bindSpawnArgs = key: args: argsVal: cmd:
      recursiveUpdate
      (setAttrByPath ["Mod+${key}" args] argsVal)
      (setAttrByPath ["Mod+${key}" "action" "spawn"] cmd);

    bindVal = key: cmd: cmdVal: setAttrByPath ["Mod+${key}" "action" cmd] cmdVal;

    bindList =
      [
        # Programs
        (bindSpawn "T" "ghostty")
        (bindSpawn "B" "google-chrome-stable")
        (bindSpawn "I" ["google-chrome-stable" "--incognito"])
        (bindSpawn "E" "nautilus")
        (bindSpawn "R" "fuzzel")
        (bindSpawn "C" "code")
        (bindSpawn "Shift+C" ["env" "XDG_CURRENT_DESKTOP=gnome" "gnome-control-center"])
        (bindSpawn "SemiColon" "spotify")
        (bindSpawn "D" "discord")
        (bindSpawn "M" "wlogout")

        # Volumes
        (bindSpawnArgs "XF86AudioRaiseVolume" "allow-when-locked" true ["wpctl" "set-volume" "-l" "2" "@DEFAULT_AUDIO_SINK@" "5%+"])
        (bindSpawnArgs "XF86AudioLowerVolume" "allow-when-locked" true ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"])
        (bindSpawnArgs "XF86AudioMute" "allow-when-locked" true ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toogle"])
        (bindSpawnArgs "XF86AudioMicMute" "allow-when-locked" true ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toogle"])

        # Brightness
        (bindSpawnArgs "XF86MonBrightnessUp" "allow-when-locked" true ["brightnessctl" "set" "+5%"])
        (bindSpawnArgs "XF86MonBrightnessDown" "allow-when-locked" true ["brightnessctl" "set" "-5%" "--min-value=1"])

        (bindArgs "O" "repeat" false "toggle-overview")

        # Window/Workspace Management
        (bind "Q" "close-window")

        (bind "H" "focus-column-left")
        (bind "L" "focus-column-right")

        (bind "Ctrl+H" "move-column-left")
        (bind "Ctrl+L" "move-column-right")

        (bind "J" "focus-window-or-workspace-down")
        (bind "K" "focus-window-or-workspace-up")

        (bind "Ctrl+J" "move-window-down-or-to-workspace-down")
        (bind "Ctrl+K" "move-window-up-or-to-workspace-up")

        (bind "Home" "focus-column-first")
        (bind "End" "focus-column-last")

        (bind "Ctrl+Home" "move-column-to-first")
        (bind "Ctrl+End" "move-column-to-last")

        (bind "Shift+H" "focus-monitor-left")
        (bind "Shift+L" "focus-monitor-right")
        (bind "Shift+J" "focus-monitor-down")
        (bind "Shift+K" "focus-monitor-up")

        (bind "Shift+Ctrl+H" "move-column-to-monitor-left")
        (bind "Shift+Ctrl+L" "move-column-to-monitor-right")
        (bind "Shift+Ctrl+J" "move-column-to-monitor-down")
        (bind "Shift+Ctrl+K" "move-column-to-monitor-up")

        (bind "Shift+U" "move-workspace-down")
        (bind "Shift+I" "move-workspace-up")

        (bindArgs "WheelScrollDown" "cooldown-ms" 150 "focus-workspace-down")
        (bindArgs "WheelScrollUp" "cooldown-ms" 150 "focus-workspace-up")
        (bindArgs "Ctrl+WheelScrollDown" "cooldown-ms" 150 "move-column-to-workspace-down")
        (bindArgs "Ctrl+WheelScrollUp" "cooldown-ms" 150 "move-column-to-workspace-up")

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
        (bind "Comma" "consume-window-into-column")
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

        (bindAttr "Shift+S" "screenshot" "show-pointer" false)
        (bindAttr "Shift+P" "screenshot-screen" "write-to-disk" true)
        (bindAttr "P" "screenshot-window" "write-to-disk" true)

        (bindArgs "Escape" "allow-inhibiting" false "toggle-keyboard-shortcuts-inhibit")

        (bindAttr "Shift+M" "quit" "skip-confirmation" true)
      ]
      ++ (
        builtins.concatLists (builtins.genList (i: let
            idx = i + 1;
          in [
            (bindVal "${toString idx}" "focus-workspace" idx)
            (bindVal "Shift+${toString idx}" "move-column-to-workspace" idx)
          ])
          9)
      );
  in
    lib.foldl' lib.recursiveUpdate {} bindList;
}
