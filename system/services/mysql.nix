{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enableMySQL {
  services.mysql = {
    package = pkgs.mariadb;
    enable = true;
  };
}
