# modules/system/mitm-ca.nix
# Add `mitm-ca` to the nixos imports and to home-manager.users.<user>.imports
# in modules/hosts/saman/default.nix, then `git add`.
{ ... }:
{
  flake.modules.nixos.mitm-ca =
    { config, lib, pkgs, ... }:
    let
      dir = "/var/lib/mitm-ca";
      bundle = "/run/mitm-ca/ca-bundle.crt";
    in
    {
      # Regenerated on every activation (boot and switch)
      system.activationScripts.mitm-ca.text = ''
        install -d -m 755 ${dir} /run/mitm-ca
        (
          umask 077
          ${pkgs.openssl}/bin/openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -nodes \
            -days 2 -subj "/CN=saman MITM CA" \
            -addext "basicConstraints=critical,CA:TRUE" \
            -addext "keyUsage=critical,keyCertSign,cRLSign" \
            -keyout ${dir}/ca.key -out ${dir}/ca.crt
        )
        chmod 644 ${dir}/ca.crt

        cat ${config.security.pki.caBundle} ${dir}/ca.crt > ${bundle}
        chmod 644 ${bundle}
      '';

      # Point the system bundle at the runtime-generated one
      environment.etc = {
        "ssl/certs/ca-certificates.crt".source = lib.mkForce bundle;
        "ssl/certs/ca-bundle.crt".source = lib.mkForce bundle;
        "pki/tls/certs/ca-bundle.crt".source = lib.mkForce bundle;
      };

      environment.sessionVariables = {
        SSL_CERT_FILE = "/run/mitm-ca/ca-bundle.crt";
        CURL_CA_BUNDLE = "/run/mitm-ca/ca-bundle.crt";
        REQUESTS_CA_BUNDLE = "/run/mitm-ca/ca-bundle.crt";
        GIT_SSL_CAINFO = "/run/mitm-ca/ca-bundle.crt";
        AWS_CA_BUNDLE = "/run/mitm-ca/ca-bundle.crt";
        DENO_CERT = "/var/lib/mitm-ca/ca.crt";
        NODE_EXTRA_CA_CERTS = "/var/lib/mitm-ca/ca.crt"; # adds to Node's roots, so it takes only the CA
      };
    };

  flake.modules.homeManager.mitm-ca =
    { pkgs, ... }:
    {
      # LibreWolf: read the CA straight from the runtime path
      programs.librewolf.policies.Certificates.Install = [ "/var/lib/mitm-ca/ca.crt" ];

      # Helium (Chromium): trust it in the NSS db
      systemd.user.services.mitm-ca-nss = {
        Unit.Description = "Trust the MITM CA in the NSS db";
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.writeShellScript "mitm-ca-nss" ''
            db=sql:$HOME/.pki/nssdb
            mkdir -p "$HOME/.pki/nssdb"
            [ -f "$HOME/.pki/nssdb/cert9.db" ] || ${pkgs.nss.tools}/bin/certutil -d "$db" -N --empty-password
            ${pkgs.nss.tools}/bin/certutil -d "$db" -D -n saman-mitm 2>/dev/null || true
            ${pkgs.nss.tools}/bin/certutil -d "$db" -A -n saman-mitm -t "C,," -i /var/lib/mitm-ca/ca.crt
          ''}";
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
}
