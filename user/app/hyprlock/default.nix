{ pkgs, ... }:
{
  programs.hyprlock = {
    package = pkgs.hyprlock;
    enable = true;

    settings = {
      background = [
        {
          color = "rgba(000000FF)";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 2;
          dots_size = 0.1;
          dots_spacing = 0.3;
          outer_color = "rgba(3B3B3B55)";
          inner_color = "rgba(33333311)";
          font_color = "rgba(FFFFFFFF)";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Clock
        {
          monitor = "";
          text = "$TIME";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(FFFFFFFF)";
          font_size = 65;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # Greeting
        {
          monitor = "";
          text = "Hi, $USER!";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(FFFFFFFF)";
          font_size = 20;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }

        # Lock Icon
        {
          monitor = "";
          text = "lock";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(FFFFFFFF)";
          font_size = 21;
          font_family = "Material Symbols Rounded";
          position = "0, 65";
          halign = "center";
          valign = "bottom";
        }

        # Locked Text
        {
          monitor = "";
          text = "Locked";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(FFFFFFFF)";
          font_size = 14;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 45";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
