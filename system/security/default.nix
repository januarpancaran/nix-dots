{ pkgs, ... }:
{
  security.apparmor.enable = true;

  security.sudo-rs.enable = true;
}
