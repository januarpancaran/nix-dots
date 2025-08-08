{ pkgs, ... }:

{
  services.mako = {
    package = pkgs.mako;
    enable = true;

    settings = {
      sort = "-time";
      layer = "overlay";
      background-color = "#2e3440";
      width = 400;
      height = 110;
      border-size = 2;
      border-color = "#88c0d0";
      border-radius = 12;
      progress-color = "#cba6f7";
      icons = 1;
      max-icon-size = 72;
      default-timeout = 5000;
      ignore-timeout = 1;
      font = "JetBrainsMono Nerd Font 14";
      icon-path = "~/.config/mako/icons/";

      "urgency=low" = {
        border-color = "#cccccc";
      };

      "urgency=normal" = {
        border-color = "#d08770";
      };

      "urgency=high" = {
        border-color = "#bf616a";
        default-timeout = 0;
      };
    };
  };

  home.file.".config/mako/icons" = {
    source = ./icons;
    recursive = true;
  };
}
