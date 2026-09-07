{ pkgs, lib, ... }:
{
  xdg.portal.enable = lib.mkForce true;

  home.packages = with pkgs; [
    grim
    pavucontrol
    polkit_gnome
    slurp
    wl-clipboard
    wl-mirror
  ];

  imports = [
    ./monitors
    ./env
    ./autostart
    ./appearance
    ./inputs
    ./binds
    ./rules
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    configType = "lua";
  };
}
