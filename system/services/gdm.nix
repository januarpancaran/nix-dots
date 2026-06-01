{ userSettings, ... }:
{
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = userSettings.username;
    };

    gdm = {
      enable = true;
    };

    defaultSession = "niri";
  };
}
