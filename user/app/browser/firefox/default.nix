{
  imports = [
    ./policies.nix
    ./profiles.nix
  ];

  programs.firefox = {
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
    enable = true;
  };
}
