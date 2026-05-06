{
    services.resolved = {
        enable = true;
        settings = {
            Resolve = {
                DNS = [ "1.1.1.1#cloudflare-dns.com" "1.0.0.1#cloudflare-dns.com" ];
                FallbackDNS = [ "8.8.8.8" "8.8.4.4" ];
                DNSOverTLS = "yes";
                DNSSEC = "yes";
                Domains = "~.";
            };
        };
    };
}
