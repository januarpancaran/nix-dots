{ config, pkgs, ... }:
{
  programs.firefox = {
    package = pkgs.firefox;
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = {
      Certificates = {
        Install = [ "/etc/ssl/certs/aspnet-dev-${config.home.username}-ca.pem" ];
      };
    };
  };
}
