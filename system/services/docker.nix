{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enableDocker {
  environment.systemPackages = with pkgs; [
    docker-buildx
    docker-compose
  ];

  virtualisation.docker = {
    enable = false;

    rootless = {
      package = pkgs.docker;
      enable = true;
      setSocketVariable = true;
    };
  };
}
