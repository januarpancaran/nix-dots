{
  lib,
  pkgs,
  userSettings,
  ...
}:
{
  security.pki.certificates =
    let
      certPath = /etc/ssl/certs/aspnet-localhost.pem;
    in
    lib.optionals (builtins.pathExists certPath) [
      (builtins.readFile certPath)
    ];

  system.activationScripts.aspnetCert = {
    text = ''
      USER_HOME=$(getent passwd ${userSettings.username} | cut -d: -f6)
      CERT_STABLE=$(ls "$USER_HOME"/.aspnet/dev-certs/trust/*.0 2>/dev/null | head -n1)

      if [ -z "$CERT_STABLE" ]; then
        echo "Warning: No ASP.NET dev cert found, skipping..."
      else
        ln -sf "$CERT_STABLE" /etc/ssl/certs/aspnet-localhost.pem
        echo "ASP.NET dev cert symlinked to /etc/ssl/certs/"

        # Ensure NSS database exists
        NSS_DB="$USER_HOME/.pki/nssdb"
        if [ ! -d "$NSS_DB" ]; then
          mkdir -p "$NSS_DB"
          ${pkgs.nssTools}/bin/certutil -d "$NSS_DB" -N --empty-password
          echo "Created NSS database at $NSS_DB"
        fi

        # Add cert to NSS database if not already present
        if ! ${pkgs.nssTools}/bin/certutil -d "$NSS_DB" -L | grep -q "localhost"; then
          ${pkgs.nssTools}/bin/certutil -d "$NSS_DB" -A -t "CT,," -n "localhost" -i "$CERT_STABLE"
          echo "ASP.NET dev cert added to NSS database"
        fi
      fi
    '';
  };
}
