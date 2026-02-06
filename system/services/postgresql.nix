{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enablePostgreSQL {
  services.postgresql = {
    package = pkgs.postgresql;
    enable = true;
  };
}
