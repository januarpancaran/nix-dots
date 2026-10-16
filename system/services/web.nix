{ userSettings, ... }:
let
  certPath = "/etc/ssl/certs/localhost-${userSettings.username}-server.pem";
  keyPath = "/etc/ssl/private/localhost-${userSettings.username}-server.key";
in
{
  # Both services use the shared localhost development certificate. They listen on
  # different ports so either service can be tested without disabling the other.
  users.groups.web-tls = { };
  users.users.nginx.extraGroups = [ "web-tls" ];
  users.users.caddy.extraGroups = [ "web-tls" ];

  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8443;
          ssl = true;
        }
      ];
      sslCertificate = certPath;
      sslCertificateKey = keyPath;
      locations."/".return = "200 'Nginx HTTPS is working\\n'";
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."https://localhost".extraConfig = ''
      tls ${certPath} ${keyPath}
      respond "Caddy HTTPS is working"
    '';
  };
}
