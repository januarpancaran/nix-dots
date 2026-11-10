{ pkgs, ... }:
{
  imports = [
    ./settings
  ];

  home.packages = with pkgs; [
    pavucontrol
    polkit_gnome
    wl-mirror
    xwayland-satellite
  ];

  programs.umbriel.enable = true;
}
