{userSettings, ...}: {
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = userSettings.username;
    };

    gdm = {
      enable = true;
      wayland = true;
    };

    defaultSession = "niri";
  };
}
