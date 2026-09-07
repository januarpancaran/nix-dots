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
  workspace = keys: number: bind keys ''hl.dsp.focus({ workspace = ${toString number} })'';
  moveWorkspace = keys: number: bind keys ''hl.dsp.window.move({ workspace = ${toString number} })'';
  workspaceRelative = keys: direction: bind keys ''hl.dsp.focus({ workspace = "${direction}" })'';
  moveWorkspaceRelative = keys: direction: {
    _args = [
      keys
      (lua ''function()
        local current = hl.get_active_workspace().id
        local target = current ${if direction == "+1" then "+ 1" else "- 1"}
        hl.dispatch(hl.dsp.window.move({ workspace = target }))
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

    (bind "SUPER + M" "hl.dsp.exit()")
    (bind "SUPER + SHIFT + S" ''hl.dsp.exec_cmd([[file="$HOME/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots" && grim -g "$(slurp)" "$file" && notify-send "Screenshot saved" "$file" || notify-send -u critical "Screenshot failed" "Region capture was cancelled or failed"]])'')
    (bind "SUPER + SHIFT + P" ''hl.dsp.exec_cmd([[output=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'); file="$HOME/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots" && grim -o "$output" "$file" && notify-send "Screenshot saved" "$file" || notify-send -u critical "Screenshot failed" "Could not capture $output"]])'')
    (bind "SUPER + P" ''hl.dsp.exec_cmd([[geometry=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'); file="$HOME/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots" && grim -g "$geometry" "$file" && notify-send "Screenshot saved" "$file" || notify-send -u critical "Screenshot failed" "Could not capture the active window"]])'')
    (bind "PRINT" ''hl.dsp.exec_cmd([[if grim - | wl-copy; then notify-send "Screenshot copied" "Output copied to clipboard"; else notify-send -u critical "Screenshot failed" "Output capture failed"; fi]])'')
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
