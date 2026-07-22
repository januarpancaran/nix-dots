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

  wsl = {
    enable = true;
    wslConf.network.hostname = systemSettings.hostname;
    defaultUser = userSettings.username;
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };

  networking.firewall.enable = true;

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

  users.users.${userSettings.username} = {
    extraGroups = [
      "podman"
    ];
    shell = if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    wget
  ];

  environment.sessionVariables = {
    NH_FLAKE = systemSettings.flakeDir;
  };

  environment.pathsToLink = [
    "/share/bash-completion"
    "/share/zsh"
  ];

  users.defaultUserShell =
    if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;

  programs.bash.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
