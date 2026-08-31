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
    extensions = with pkgs.postgresqlPackages; [
      pgvector
    ];
  };
}
