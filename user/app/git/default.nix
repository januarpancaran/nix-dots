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
        name = userSettings.gitUsername;
        email = userSettings.gitEmail;
      };

      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
