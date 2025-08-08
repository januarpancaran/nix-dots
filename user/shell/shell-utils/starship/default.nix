{pkgs, ...}: {
  programs.starship = {
    package = pkgs.starship;
    enable = true;
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
