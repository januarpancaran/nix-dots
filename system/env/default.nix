{
  systemSettings,
  userSettings,
  ...
}: {
  environment.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = 24;
    XDG_CURRENT_DESKTOP = userSettings.wm;
    XDG_SESSION_DESKTOP = userSettings.wm;
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    GDK_BACKEND = "wayland,x11,*";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
    NH_FLAKE = systemSettings.flakeDir;
  };

  environment.pathsToLink = ["/share/zsh"];
}
