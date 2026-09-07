{ lib, userSettings, ... }:
let
  lua = lib.generators.mkLuaInline;
  browser =
    if userSettings.defaultBrowser == "google-chrome" then
      "google-chrome-stable"
    else
      userSettings.defaultBrowser;
  privateBrowser =
    if userSettings.defaultBrowser == "google-chrome" then
      "google-chrome-stable --incognito"
    else if userSettings.defaultBrowser == "firefox" then
      "firefox --private-window"
    else
      "${userSettings.defaultBrowser} --incognito";
  bind = keys: dispatcher: {
    _args = [ keys (lua dispatcher) ];
  };
  exec = keys: command: bind keys ''hl.dsp.exec_cmd("${command}")'';
  focus = keys: direction: bind keys ''hl.dsp.focus({ direction = "${direction}" })'';
  move = keys: direction: bind keys ''hl.dsp.window.move({ direction = "${direction}" })'';
  workspace = keys: number: {
    _args = [
      keys
      (lua ''function()
        local target = ${toString number}
        local allowed = true
        for required = 1, target - 1 do
          local used = false
          for _, ws in ipairs(hl.get_workspaces()) do
            if ws.id == required and ws.windows > 0 then
              used = true
              break
            end
          end
          if not used then
            allowed = false
            break
          end
        end
        if allowed then
          hl.dispatch(hl.dsp.focus({ workspace = target }))
        end
      end'')
    ];
  };
  moveWorkspace = keys: number: {
    _args = [
      keys
      (lua ''function()
        local target = ${toString number}
        local allowed = true
        for required = 1, target - 1 do
          local used = false
          for _, ws in ipairs(hl.get_workspaces()) do
            if ws.id == required and ws.windows > 0 then
              used = true
              break
            end
          end
          if not used then
            allowed = false
            break
          end
        end
        if allowed then
          local target_used = false
          for _, ws in ipairs(hl.get_workspaces()) do
            if ws.id == target and ws.windows > 0 then
              target_used = true
              break
            end
          end
          if target_used then
            hl.dispatch(hl.dsp.window.move({ workspace = target }))
          end
        end
      end'')
    ];
  };
  workspaceRelative = keys: direction: bind keys ''hl.dsp.focus({ workspace = "${direction}" })'';
  moveWorkspaceRelative = keys: direction: {
    _args = [
      keys
      (lua ''function()
        local current = hl.get_active_workspace().id
        local target = current ${if direction == "+1" then "+ 1" else "- 1"}
        for _, ws in ipairs(hl.get_workspaces()) do
          if ws.id == target and ws.windows > 0 then
            hl.dispatch(hl.dsp.window.move({ workspace = target }))
            return
          end
        end
      end'')
    ];
  };
  workspaceBinds = builtins.concatLists (builtins.genList (i: [
    (workspace "SUPER + ${toString (i + 1)}" (i + 1))
    (moveWorkspace "SUPER + SHIFT + ${toString (i + 1)}" (i + 1))
  ]) 9);
  simpleBinds = [
    (exec "SUPER + T" "ghostty")
    (exec "SUPER + B" browser)
    (exec "SUPER + I" privateBrowser)
    (exec "SUPER + E" "nautilus")
    (exec "SUPER + C" "zeditor")
    (exec "SUPER + SHIFT + C" "env XDG_CURRENT_DESKTOP=gnome gnome-control-center")
    (exec "SUPER + SEMICOLON" "env -u DISPLAY spotify --enable-wayland-ime")
    (exec "SUPER + D" "discord")
    (exec "SUPER + R" "noctalia msg panel-toggle launcher")
    (exec "SUPER + S" "noctalia msg panel-toggle control-center")
    (exec "SUPER + COMMA" "noctalia msg settings-toggle")
    (bind "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("noctalia msg volume-up")'')
    (bind "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("noctalia msg volume-down")'')
    (bind "XF86AudioMute" ''hl.dsp.exec_cmd("noctalia msg volume-mute")'')
    (bind "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("noctalia msg brightness-up")'')
    (bind "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("noctalia msg brightness-down")'')
    (bind "SUPER + Q" "hl.dsp.window.close()")
    (focus "SUPER + H" "left")
    (focus "SUPER + L" "right")
    (workspaceRelative "SUPER + J" "+1")
    (workspaceRelative "SUPER + K" "-1")
    (move "SUPER + SHIFT + H" "left")
    (move "SUPER + SHIFT + L" "right")
    (moveWorkspaceRelative "SUPER + SHIFT + J" "+1")
    (moveWorkspaceRelative "SUPER + SHIFT + K" "-1")
    (bind "SUPER + V" ''hl.dsp.window.float({ action = "toggle" })'')
    (bind "SUPER + F" "hl.dsp.window.fullscreen()")
    (bind "SUPER + P" "hl.dsp.window.pseudo()")
    (bind "SUPER + M" "hl.dsp.exit()")
    (bind "SUPER + SHIFT + S" ''hl.dsp.exec_cmd("grim -g \\\"$(slurp)\\\" - | wl-copy")'')
    (bind "PRINT" ''hl.dsp.exec_cmd("grim - | wl-copy")'')
    (bind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
    (bind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')
    (moveWorkspaceRelative "SUPER + CTRL + mouse_down" "+1")
    (moveWorkspaceRelative "SUPER + CTRL + mouse_up" "-1")
    (bind "SUPER + mouse:272" "hl.dsp.window.drag()")
    (bind "SUPER + mouse:273" "hl.dsp.window.resize()")
    (bind "SUPER + SHIFT + Q" "hl.dsp.exec_cmd(\"hyprshutdown\")")
  ];
in
{
  wayland.windowManager.hyprland.settings.bind = simpleBinds ++ workspaceBinds;
}
