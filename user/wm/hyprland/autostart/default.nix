{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  compactWorkspaces = ''
    function()
        -- Debouncing: cancel previous timer if it exists
        if compact_timer ~= nil and compact_timer.cancel ~= nil then
          compact_timer:cancel()
        end
        
        compact_timer = hl.timer(function()
          local workspaces = hl.get_workspaces()
          local current_ws = hl.get_active_workspace().id
          
          -- Build a map of workspace IDs with their window counts
          local ws_map = {}
          for _, ws in ipairs(workspaces) do
            if ws.id >= 1 then
              ws_map[ws.id] = ws.windows
            end
          end
          
          -- Find all occupied workspaces (sorted)
          local occupied = {}
          for id, windows in pairs(ws_map) do
            if windows > 0 then
              table.insert(occupied, id)
            end
          end
          table.sort(occupied)
          
          -- Check if compacting is needed
          local needs_compact = false
          for i, id in ipairs(occupied) do
            if id ~= i then
              needs_compact = true
              break
            end
          end
          
          if not needs_compact then
            compact_timer = nil
            return
          end
          
          -- Check if workspace 1 is empty (needs special focus handling)
          local ws1_empty = (ws_map[1] == nil or ws_map[1] == 0) and #occupied > 0
          
          -- Move windows to compact positions
          for i, source_id in ipairs(occupied) do
            if source_id ~= i then
              local workspace = nil
              for _, ws in ipairs(hl.get_workspaces()) do
                if ws.id == source_id then
                  workspace = ws
                  break
                end
              end
              
              if workspace ~= nil then
                for _, window in ipairs(workspace:get_windows()) do
                  hl.dispatch(hl.dsp.window.move({
                    window = window,
                    workspace = i,
                  }))
                end
              end
            end
          end
          
          -- If workspace 1 was empty and we're on it, stay on workspace 1
          if ws1_empty and current_ws == 1 then
            hl.dispatch(hl.dsp.focus({ workspace = 1 }))
          end
          
          compact_timer = nil
        end, { timeout = 200, type = "oneshot" })
      end'';
  compactEvent = lua ''
    function()
        if compact_workspaces ~= nil then
          compact_workspaces()
        end
      end'';
in
{
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lua ''
          function()
                    compact_timer = nil
                    compact_workspaces = ${compactWorkspaces}
                    hl.exec_cmd("fcitx5 -d -r")
                    hl.exec_cmd("fcitx5-remote -d -r")
                    hl.exec_cmd("noctalia --daemon")
                    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Dracula")
                    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Tela-nord-dark")
                    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Elaina")
                    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
                  end'')
      ];
    }
    {
      _args = [
        "window.close"
        compactEvent
      ];
    }
    {
      _args = [
        "window.move_to_workspace"
        compactEvent
      ];
    }
    {
      _args = [
        "workspace.active"
        compactEvent
      ];
    }
    {
      # Re-initialize after sleep/wake: hyprland.start only fires once at startup,
      # so compact_workspaces global is lost after suspend. monitor.added fires when
      # the display comes back, restoring the function.
      _args = [
        "monitor.added"
        (lua ''
          function()
            compact_workspaces = ${compactWorkspaces}
            compact_timer = nil
          end'')
      ];
    }
  ];
}
