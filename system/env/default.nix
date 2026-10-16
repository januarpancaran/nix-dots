{ lib, 
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
let
  chromeExecutable =
    if builtins.elem "google-chrome" userSettings.enableBrowsers && userSettings.defaultBrowser == "google-chrome" then
      "google-chrome-stable"
    else if builtins.elem "vivaldi" userSettings.enableBrowsers && userSettings.defaultBrowser == "vivaldi" then
      "vivaldi"
    else if builtins.elem "brave-origin" userSettings.enableBrowsers && userSettings.defaultBrowser == "brave-origin" then
      "brave-origin"
    else
      null;
in
{
  environment.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Elaina";
    XCURSOR_SIZE = 32;
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    GDK_BACKEND = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
    NH_FLAKE = systemSettings.flakeDir;
  }
  // lib.optionalAttrs (chromeExecutable != null) {
    CHROME_EXECUTABLE = chromeExecutable;
  }
  // lib.optionalAttrs (systemSettings.enableSteam or false) {
    # Keep NVIDIA's shader cache from evicting compiled shaders in large games.
    "__GL_SHADER_DISK_CACHE_SIZE" = "12000000000";
  };

  environment.pathsToLink = [
    "/share/bash-completion"
    "/share/zsh"
  ];
}
