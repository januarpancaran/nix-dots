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
    ../../system/fonts
    ../../system/services/dbus.nix
    ../../system/services/docker.nix
    ../../system/services/mysql.nix
    ../../system/services/others.nix
  ];

  wsl = {
    enable = true;
    defaultUser = userSettings.username;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;

    wslConf.network.hostname = systemSettings.hostname;
  };

  networking.firewall.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    trusted-users = ["root" "@wheel"];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  environment.sessionVariables = {
    NH_FLAKE = systemSettings.flakeDir;
  };

  environment.pathsToLink = ["/share/zsh"];

  users.defaultUserShell = pkgs.zsh;

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
