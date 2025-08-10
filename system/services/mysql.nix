{pkgs, ...}: {
  services.mysql = {
    package = pkgs.mariadb;
    enable = true;
  };
}
