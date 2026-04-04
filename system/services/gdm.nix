{
  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };

    defaultSession = "niri";
  };
}
