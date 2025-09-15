{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    package = pkgs.rofi;
    enable = true;

    extraConfig = {
      modi = "window,run,drun";
      display-drun = "Applications:";
      display-window = "Windows:";
      show-icons = true;
      icon-theme = "Tela-nord-dark";
      drun-display-format = "{icon} {name}";
      font = "JetBrainsMono NF Medium 10";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1e1e2e";
        bg-alt = mkLiteral "#cba6f7";
        background-color = mkLiteral "@bg";
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      "#window" = {
        width = mkLiteral "45%";
        border-radius = mkLiteral "12px";
      };

      "#element" = {
        padding = 12;
        text-color = mkLiteral "@bg-alt";
      };

      "#element.selected" = {
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@bg";
      };

      "#element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };

      "#element-icon" = {
        size = 30;
      };

      "#prompt" = {
        background-color = mkLiteral "@bg-alt";
        enabled = true;
        padding = mkLiteral "12 0 0 12";
        text-color = mkLiteral "@bg";
      };

      "#entry" = {
        background-color = mkLiteral "@bg-alt";
        padding = 12;
        text-color = mkLiteral "@bg";
      };

      "#inputbar" = {
        children = map mkLiteral ["prompt" "entry"];
      };

      "#listview" = {
        background-color = mkLiteral "@bg";
        columns = 1;
        lines = 8;
      };

      "#mainbox" = {
        background-color = mkLiteral "@bg";
        children = map mkLiteral ["inputbar" "listview"];
      };
    };
  };
}
