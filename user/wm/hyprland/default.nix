{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  xdg.portal.enable = lib.mkForce true;

  home.packages = with pkgs; [
    grim
    pavucontrol
    polkit_gnome
    slurp
    socat
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
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    configType = "lua";
  };
}
