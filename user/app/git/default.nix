{
  pkgs,
  userSettings,
  ...
}: {
  programs.git = {
    package = pkgs.git;
    enable = true;

    userName = userSettings.githubUsername;
    userEmail = userSettings.githubEmail;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
