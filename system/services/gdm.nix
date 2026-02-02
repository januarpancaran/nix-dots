{
  lib,
  userSettings,
  ...
}:
{
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = userSettings.username;
    };

    gdm = {
      enable = true;
      wayland = true;
    };

    defaultSession = lib.strings.toLower userSettings.wm;
  };
}
