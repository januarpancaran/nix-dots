{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = import ../../lib/autoImport.nix {
    inherit lib;
    registry = ../../modules/system.nix;
    profile = systemSettings.profile;
  };

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
    mesa-demos
    trash-cli
  ];

  system.stateVersion = "25.05";
}
