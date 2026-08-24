{ ... }:
{
  programs.mangohud = {
    enable = true;

    settings = {
      # --- Display Core Metrics ---
      fps = true;
      frametime = true;
      fps_metrics = "avg,0.01";
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      ram = true;
      vram = true;

      # --- Formatting & Layout ---
      horizontal = false;
      hud_no_margin = true;
      font_size = 24;
      round_corners = 10;
      background_alpha = 0.4;
      alpha = 0.9;
      position = "top-left";

      # --- Colors (Hex) ---
      text_color = "FFFFFF";
      gpu_color = "2ecc71";
      cpu_color = "3498db";
      fps_color = "f1c40f";
      ram_color = "e67e22";

      # --- Limits & Shortcuts ---
      # fps_limit = 60;
      toggle_hud = "Shift_R+F12";
    };
  };
}
