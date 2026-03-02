{
  lib,
  userSettings,
  ...
}:
{
  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };

    defaultSession = lib.strings.toLower userSettings.wm;
  };
}
