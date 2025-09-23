{
  programs.niri.settings.environment = {
    "XDG_SESSION_TYPE" = "wayland";
    "XDG_CURRENT_DESKTOP" = "niri";
    "XDG_SESSION_DESKTOP" = "niri";
    "QT_QPA_PLATFORMTHEME" = "qt6ct";
    "QT_QPA_PLATFORM" = "wayland";
    "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
    "GDK_BACKEND" = "wayland";
    "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
    "MOZ_ENABLE_WAYLAND" = "1";
    "NIXOS_OZONE_WL" = "1";
  };
}
