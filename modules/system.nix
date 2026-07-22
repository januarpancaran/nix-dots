[
  {
    path = ../system/app/android.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/app/appimage.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/app/nh.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/app/nix-ld.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/app/steam.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/boot/bootloader.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/boot/kernel.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/env;
    profiles = [ "personal" ];
  }
  {
    path = ../system/fonts;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/hardware-configuration.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/hardware/bluetooth.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/hardware/intel.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/hardware/nvidia.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/inputs/fcitx5.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/security;
    profiles = [ "personal" ];
  }
  {
    path = ../system/security/aspnet-devcert.nix;
    profiles = [ "wsl" ];
  }
  {
    path = ../system/services/dbus.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/services/flatpak.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/gdm.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/gnome-keyring.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/mysql.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/services/others.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/services/pipewire.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/podman.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/services/postgresql.nix;
    profiles = [
      "personal"
      "wsl"
    ];
  }
  {
    path = ../system/services/power.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/systemd-resolved.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/vm.nix;
    profiles = [ "personal" ];
  }
  {
    path = ../system/services/xdg-portal.nix;
    profiles = [ "personal" ];
  }
]
