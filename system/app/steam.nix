{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enableSteam {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
