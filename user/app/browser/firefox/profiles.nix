{ userSettings, ... }:
{
  programs.firefox.profiles = {
    ${userSettings.username} = {
      id = 0;
      name = userSettings.username;
      isDefault = true;

      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "ddg"
        ];
      };
    };
  };
}
