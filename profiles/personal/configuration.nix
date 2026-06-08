{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = [
    ../../system/app/android.nix
    ../../system/app/appimage.nix
    ../../system/app/nh.nix
    ../../system/app/nix-ld.nix
    ../../system/app/steam.nix
    ../../system/boot/bootloader.nix
    ../../system/boot/kernel.nix
    ../../system/env
    ../../system/fonts
    ../../system/hardware-configuration.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/intel.nix
    ../../system/hardware/nvidia.nix
    ../../system/inputs/fcitx5.nix
    ../../system/security
    ../../system/services/dbus.nix
    ../../system/services/flatpak.nix
    ../../system/services/gdm.nix
    ../../system/services/gnome-keyring.nix
    ../../system/services/mysql.nix
    ../../system/services/others.nix
    ../../system/services/pipewire.nix
    ../../system/services/podman.nix
    ../../system/services/postgresql.nix
    ../../system/services/power.nix
    ../../system/services/systemd-resolved.nix
    ../../system/services/vm.nix
    ../../system/services/xdg-portal.nix
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
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  users = {
    users.${userSettings.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "networkmanager"
        "libvirtd"
        "podman"
      ];
      shell = if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;
    };

    defaultUserShell = if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;
  };

  hardware.enableAllFirmware = true;

  programs.niri.enable = true;
  programs.bash.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    libnotify
    trash-cli
  ];

  system.stateVersion = "25.05";
}
