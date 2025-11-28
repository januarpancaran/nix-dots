{pkgs, ...}: {
  imports = [
    ./settings
  ];

  programs.vscode = {
    package = pkgs.vscode;
    enable = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
    };
  };
}
