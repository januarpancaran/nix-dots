{pkgs, ...}: {
  services.cloudflare-warp = {
    package = pkgs.cloudflare-warp;
    enable = true;
    openFirewall = true;
  };
}
