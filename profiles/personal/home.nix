{
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = import ../../lib/autoImport.nix {
    inherit lib;
    registry = ../../modules/home.nix;
    profile = systemSettings.profile;
  };

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {
      FLAKE_PROFILE = "personal";
      EDITOR = "nvim";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
      DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
      PSHOME = "${pkgs.powershell}/lib/powershell";
      POWERSHELL_TELEMETRY_OPTOUT = "1";
    };
  };

  programs.home-manager.enable = true;
}
