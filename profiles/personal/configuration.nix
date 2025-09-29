{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    ../../system/app/nh.nix
    ../../system/app/steam.nix
    ../../system/boot/bootloader.nix
    ../../system/boot/kernel.nix
    ../../system/env
    ../../system/fonts
    ../../system/hardware-configuration.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/intel.nix
    ../../system/hardware/nvidia.nix
    ../../system/security
    ../../system/services/btrfs-autoscrub.nix
    ../../system/services/dbus.nix
    ../../system/services/docker.nix
    ../../system/services/flatpak.nix
    ../../system/services/gdm.nix
    ../../system/services/mysql.nix
    ../../system/services/others.nix
    ../../system/services/pipewire.nix
    ../../system/services/tlp.nix
    ../../system/udev-rules
  ];

  networking.hostName = systemSettings.hostname;

  networking.networkmanager = {
    enable = lib.mkDefault true;
    wifi.powersave = true;
  };

  networking.firewall.enable = lib.mkDefault true;

  time.timeZone = systemSettings.timeZone;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "de_DE.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    trusted-users = ["root" "@wheel"];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  users = {
    users.${userSettings.username} = {
      isNormalUser = true;
      extraGroups = ["wheel" "video" "audio" "networkmanager"];
    };

    defaultUserShell = pkgs.zsh;
  };

  programs.niri.enable = userSettings.wm == "niri";
  programs.hyprland.enable = userSettings.wm == "Hyprland";
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    cudatoolkit
    libnotify
    trash-cli
  ];

  system.stateVersion = "25.05";
}
