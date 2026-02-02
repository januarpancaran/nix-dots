{ pkgs, ... }:
{
  services.swww = {
    package = pkgs.swww;
    enable = true;
  };
}
