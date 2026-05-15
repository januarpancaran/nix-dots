{
  lib,
  pkgs,
  userSettings,
  ...
}:
let
  caCertPath = "/etc/ssl/certs/aspnet-dev-${userSettings.username}-ca.pem";
in
{
  security.pki.certificates =
    lib.optionals (builtins.pathExists caCertPath) [
      (builtins.readFile caCertPath)
    ];

  system.activationScripts.aspnetCert = {
    text = ''
      set -euo pipefail

      USER_HOME=$(getent passwd ${userSettings.username} | cut -d: -f6)
      if [ -z "$USER_HOME" ]; then
        echo "Warning: user ${userSettings.username} not found, skipping ASP.NET dev cert setup."
        exit 0
      fi

      CA_CERT_PATH="${caCertPath}"
      HOSTNAME=$(${pkgs.coreutils}/bin/cat /proc/sys/kernel/hostname)
      ASP_NET_DIR="$USER_HOME/.aspnet"
      DEV_CERTS_DIR="$ASP_NET_DIR/dev-certs"
      TRUST_DIR="$DEV_CERTS_DIR/trust"
      LEGACY_CERT="/etc/ssl/certs/aspnet-localhost.pem"

      if [ -f "$LEGACY_CERT" ]; then
        ${pkgs.coreutils}/bin/rm -f "$LEGACY_CERT"
      fi

      ${pkgs.coreutils}/bin/install -d -m 700 -o ${userSettings.username} -g users \
        "$ASP_NET_DIR" "$DEV_CERTS_DIR" "$TRUST_DIR"
      if [ "$(${pkgs.coreutils}/bin/stat -c %U "$ASP_NET_DIR")" != "${userSettings.username}" ]; then
        ${pkgs.coreutils}/bin/chown -R ${userSettings.username} "$ASP_NET_DIR"
      fi

      CERT_FILE=$(${pkgs.coreutils}/bin/ls "$TRUST_DIR"/aspnetcore-localhost-*.pem 2>/dev/null | ${pkgs.coreutils}/bin/head -n1 || true)

      needs_refresh=0
      if [ ! -f "$CA_CERT_PATH" ] || [ -z "$CERT_FILE" ]; then
        needs_refresh=1
      elif ! ${pkgs.openssl}/bin/openssl x509 -in "$CERT_FILE" -noout -checkend 0 >/dev/null 2>&1; then
        needs_refresh=1
      fi

      if [ "$needs_refresh" -eq 1 ]; then
        WORKDIR=$(${pkgs.coreutils}/bin/mktemp -d)
        cleanup() { ${pkgs.coreutils}/bin/rm -rf "$WORKDIR"; }
        trap cleanup EXIT

        CA_CONFIG="$WORKDIR/ca.cnf"
        DEV_CONFIG="$WORKDIR/dev.cnf"

        ${pkgs.coreutils}/bin/cat > "$CA_CONFIG" <<-EOF
	[ req ]
	prompt = no
	distinguished_name = dn
	x509_extensions = ca_ext

	[ dn ]
	O = ASP.NET Core dev CA
	OU = ${userSettings.username}@''${HOSTNAME}

	[ ca_ext ]
	basicConstraints = critical,CA:TRUE,pathlen:1
	keyUsage = critical,keyCertSign
	subjectKeyIdentifier = hash
	authorityKeyIdentifier = keyid:always
	EOF

        ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes \
          -days 3650 -keyout "$WORKDIR/ca.key" -out "$WORKDIR/ca.pem" \
          -config "$CA_CONFIG"

        ${pkgs.coreutils}/bin/cat > "$DEV_CONFIG" <<-'EOF'
	[ req ]
	prompt = no
	distinguished_name = dn
	req_extensions = req_ext

	[ dn ]
	CN = localhost

	[ req_ext ]
	basicConstraints = critical,CA:FALSE
	keyUsage = critical,digitalSignature,keyEncipherment
	extendedKeyUsage = serverAuth
	subjectAltName = @alt_names
	1.3.6.1.4.1.311.84.1.1 = DER:06

	[ x509_ext ]
	basicConstraints = critical,CA:FALSE
	keyUsage = critical,digitalSignature,keyEncipherment
	extendedKeyUsage = serverAuth
	subjectAltName = @alt_names
	subjectKeyIdentifier = hash
	authorityKeyIdentifier = keyid,issuer
	1.3.6.1.4.1.311.84.1.1 = DER:06

	[ alt_names ]
	DNS.1 = localhost
	DNS.2 = *.dev.localhost
	DNS.3 = *.dev.internal
	DNS.4 = host.docker.internal
	DNS.5 = host.containers.internal
	IP.1 = 127.0.0.1
	IP.2 = ::1
	EOF

        ${pkgs.openssl}/bin/openssl req -new -newkey rsa:2048 -nodes \
          -keyout "$WORKDIR/dev.key" -out "$WORKDIR/dev.csr" \
          -config "$DEV_CONFIG"

        ${pkgs.openssl}/bin/openssl x509 -req \
          -in "$WORKDIR/dev.csr" \
          -CA "$WORKDIR/ca.pem" -CAkey "$WORKDIR/ca.key" -CAcreateserial \
          -out "$WORKDIR/dev.pem" -days 365 \
          -extfile "$DEV_CONFIG" -extensions x509_ext

        ${pkgs.coreutils}/bin/mkdir -p /etc/ssl/certs
        ${pkgs.coreutils}/bin/install -m 0644 "$WORKDIR/ca.pem" "$CA_CERT_PATH"
        ${pkgs.coreutils}/bin/chmod 0644 "$WORKDIR"/dev.pem "$WORKDIR"/ca.pem

        CERT_THUMBPRINT=$(${pkgs.openssl}/bin/openssl x509 -noout -fingerprint -sha1 -in "$WORKDIR/dev.pem" | ${pkgs.coreutils}/bin/cut -d= -f2 | ${pkgs.coreutils}/bin/tr -d ':' | ${pkgs.coreutils}/bin/tr '[:lower:]' '[:upper:]')
        CERT_NICKNAME="aspnetcore-localhost-$CERT_THUMBPRINT"
        CERT_FILE="$TRUST_DIR/$CERT_NICKNAME.pem"

        ${pkgs.coreutils}/bin/install -m 0644 -o ${userSettings.username} -g users \
          "$WORKDIR/dev.pem" "$TRUST_DIR/$CERT_NICKNAME.pem"
        ${pkgs.coreutils}/bin/install -m 0644 -o ${userSettings.username} -g users \
          "$WORKDIR/ca.pem" "$TRUST_DIR/aspnet-dev-${userSettings.username}-ca.pem"

        CA_HASH=$(${pkgs.openssl}/bin/openssl x509 -hash -noout -in "$TRUST_DIR/aspnet-dev-${userSettings.username}-ca.pem")
        ${pkgs.coreutils}/bin/ln -sf "aspnet-dev-${userSettings.username}-ca.pem" "$TRUST_DIR/$CA_HASH.0"
        ${pkgs.coreutils}/bin/chown -h ${userSettings.username}:users "$TRUST_DIR/$CA_HASH.0"

        PFX_PASSWORD="aspnet-devcert"
        ${pkgs.openssl}/bin/openssl pkcs12 -export \
          -out "$WORKDIR/dev.pfx" -inkey "$WORKDIR/dev.key" -in "$WORKDIR/dev.pem" \
          -passout "pass:$PFX_PASSWORD"
        ${pkgs.coreutils}/bin/chown ${userSettings.username} "$WORKDIR" "$WORKDIR/dev.pfx"
        ${pkgs.coreutils}/bin/chmod 700 "$WORKDIR"
        ${pkgs.coreutils}/bin/chmod 600 "$WORKDIR/dev.pfx"

        ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
          ${pkgs.coreutils}/bin/env HOME="$USER_HOME" USER="${userSettings.username}" LOGNAME="${userSettings.username}" DOTNET_CLI_HOME="$USER_HOME" \
          ${pkgs.dotnet-sdk_10}/bin/dotnet dev-certs https --clean --import "$WORKDIR/dev.pfx" --password "$PFX_PASSWORD"

        echo "ASP.NET dev cert generated and installed."
      fi

      if [ -n "$CERT_FILE" ] && [ -f "$CERT_FILE" ]; then
        CERT_NICKNAME=$(${pkgs.coreutils}/bin/basename "$CERT_FILE" .pem)

        NSS_DB="$USER_HOME/.pki/nssdb"
        if [ -d "$USER_HOME/.pki" ] && [ "$(${pkgs.coreutils}/bin/stat -c %U "$USER_HOME/.pki")" != "${userSettings.username}" ]; then
          ${pkgs.coreutils}/bin/chown -R ${userSettings.username} "$USER_HOME/.pki"
        fi
        if [ ! -d "$NSS_DB" ]; then
          ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
            ${pkgs.coreutils}/bin/mkdir -p "$NSS_DB"
          ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
            ${pkgs.nssTools}/bin/certutil -d "sql:$NSS_DB" -N --empty-password
        fi

        if ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
          ${pkgs.nssTools}/bin/certutil -d "sql:$NSS_DB" -L | ${pkgs.gnugrep}/bin/grep -q "$CERT_NICKNAME"; then
          ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
            ${pkgs.nssTools}/bin/certutil -d "sql:$NSS_DB" -D -n "$CERT_NICKNAME"
        fi
        ${pkgs.util-linux}/bin/runuser -u ${userSettings.username} -- \
          ${pkgs.nssTools}/bin/certutil -d "sql:$NSS_DB" -A -t "P,," -n "$CERT_NICKNAME" -i "$CERT_FILE"
      else
        echo "Warning: ASP.NET dev cert not found, skipping NSS trust."
      fi
    '';
  };
}
