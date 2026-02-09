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
    ../../system/app/nh.nix
    ../../system/fonts
    ../../system/services/dbus.nix
    ../../system/services/mysql.nix
    ../../system/services/others.nix
    ../../system/services/postgresql.nix
  ];

  wsl = {
    enable = true;
    defaultUser = userSettings.username;
    docker-desktop.enable = true;
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

  virtualisation.docker.enable = true;
  users.users.${userSettings.username} = {
    extraGroups = [ "docker" ];
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

  programs.nix-ld.enable = true;
  programs.bash.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
