{ pkgs, ... }:
{
  imports = [
    ./aspnet-devcert.nix
  ];

  security.apparmor.enable = true;

  security.sudo-rs.enable = true;
}
