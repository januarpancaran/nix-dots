{
  programs.zed-editor.userSettings = {
    edit_predictions = {
      provider = "copilot";
    };

    git_panel = {
      dock = "left";
    };

    project_panel = {
      dock = "right";
    };

    telemetry = {
      diagnostics = false;
      metrics = false;
    };

    session = {
      trust_all_worktrees = true;
    };

    vim_mode = true;

    terminal = {
      font_family = "JetBrainsMono Nerd Font";
    };

    base_keymap = "VSCode";
    relative_line_numbers = "enabled";

    gutter = {
      line_numbers = true;
    };

    buffer_font_family = "JetBrainsMono Nerd Font";
    icon_theme = "VSCode Icons for Zed (Dark Angular)";

    ui_font_size = 16;
    buffer_font_size = 16.0;

    theme = {
      mode = "dark";
      light = "Rosé Pine Dawn";
      dark = "Rosé Pine Moon";
    };
  };
}
