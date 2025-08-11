{ pkgs, ... }:

{
  home.packages = with pkgs; [
    acpi 
    brightnessctl
    jq
    inotify-tools
    pulseaudio
  ];

  programs.eww = {
    package = pkgs.eww;
    enable = true;
  };

  home.file.".config/eww" = {
    source = ./bar;
    recursive = true;
  };
}
