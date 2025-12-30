{pkgs, ...}: {
  services.postgresql = {
    package = pkgs.postgresql;
    enable = true;
  };
}
