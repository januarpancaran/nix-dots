{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lua ''function()
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
        (lua ''function()
          hl.timer(function()
            local workspaces = hl.get_workspaces()
            local first_empty = nil
            local highest = 0

            for _, workspace in ipairs(workspaces) do
              if workspace.id > highest then
                highest = workspace.id
              end
              if workspace.id >= 1 and workspace.windows == 0 and first_empty == nil then
                first_empty = workspace.id
              end
            end

            if first_empty == nil then
              return
            end

            for source_id = first_empty + 1, highest do
              local source = nil
              for _, workspace in ipairs(hl.get_workspaces()) do
                if workspace.id == source_id then
                  source = workspace
                  break
                end
              end

              if source ~= nil then
                for _, window in ipairs(source:get_windows()) do
                  hl.dispatch(hl.dsp.window.move({
                    window = window,
                    workspace = source_id - 1,
                  }))
                end
              end
            end
          end, { timeout = 100, type = "oneshot" })
        end'')
      ];
    }
  ];
}
