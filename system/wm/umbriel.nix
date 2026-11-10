{ inputs, pkgs, ... }:
{
  imports = [ inputs.umbriel.nixosModules.default ];

  programs.umbriel.enable = true;

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];
}
