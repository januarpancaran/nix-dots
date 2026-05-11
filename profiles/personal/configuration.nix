{
  config,
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = [
    ../../system/app/nh.nix
    ../../system/app/steam.nix
    ../../system/boot/bootloader.nix
    ../../system/boot/kernel.nix
    ../../system/env
    ../../system/fonts
    ../../system/hardware-configuration.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/intel.nix
    ../../system/hardware/nvidia.nix
    ../../system/security
    ../../system/services/dbus.nix
    ../../system/services/flatpak.nix
    ../../system/services/gdm.nix
    ../../system/services/mysql.nix
    ../../system/services/others.nix
    ../../system/services/pipewire.nix
    ../../system/services/podman.nix
    ../../system/services/postgresql.nix
    ../../system/services/power.nix
    ../../system/services/systemd-resolved.nix
    ../../system/services/vm.nix
    ../../system/udev-rules
  ];

  networking.hostName = systemSettings.hostname;

  networking.networkmanager = {
    enable = lib.mkDefault true;
    wifi.powersave = true;
  };

  networking.firewall.enable = lib.mkDefault true;

  time.timeZone = systemSettings.timeZone;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  users = {
    users.${userSettings.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "networkmanager"
        "libvirtd"
      ];
      shell = if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;
    };

    defaultUserShell = if userSettings.defaultShell == "bash" then pkgs.bashInteractive else pkgs.zsh;
  };

  hardware.enableAllFirmware = true;

  programs.niri.enable = true;
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      stdenv.cc.cc.lib
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      libXcomposite
      libXtst
      libXrandr
      libXext
      libX11
      libXfixes
      libGL
      libva
      pipewire
      libxcb
      libXdamage
      libxshmfence
      libXxf86vm
      libelf

      # Required
      glib
      gtk2

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM

      # # Without these it silently fails
      libXinerama
      libXcursor
      libXrender
      libXScrnSaver
      libXi
      libSM
      libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim

      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed

      # Verified games requirements
      libXt
      libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew_1_10
      libidn
      tbb

      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager
    libnotify
    trash-cli
  ];

  system.stateVersion = "25.05";
}
