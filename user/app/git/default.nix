{
  pkgs,
  userSettings,
  ...
}:
{
  programs.git = {
    package = pkgs.git;
    enable = true;

    settings = {
      user = {
        name = userSettings.githubUsername;
        email = userSettings.githubEmail;
      };

      init.defaultBranch = "main";
    };
  };
}
