{
  imports = [
    ./policies.nix
    ./profiles.nix
  ];

  programs.zen-browser = {
    enable = true;
  };
}
