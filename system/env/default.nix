{
    lib,
    pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  environment.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = 24;
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    GDK_BACKEND = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
    NH_FLAKE = systemSettings.flakeDir;

    LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc.lib  # libstdc++ - for anything with C++ extensions
    libz              # libz - compression, used by numpy, pillow, etc
    pipewire          # audio
    
    # Common for data science / ML
    libGL             # OpenGL - opencv, matplotlib
    glib              # libglib - many packages depend on this
    
    # Common for web / networking
    openssl           # SSL - requests, httpx, cryptography
    curl              # libcurl
    
    # Common for image processing
    libjpeg           # Pillow
    libpng            # Pillow
    libwebp           # Pillow
    
    # Common for database
    sqlite            # most projects use sqlite
    ]));
  };

  environment.pathsToLink = [
    "/share/bash-completion"
    "/share/zsh"
  ];
}
