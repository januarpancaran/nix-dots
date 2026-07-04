{
  lib,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (builtins.elem "vivaldi" userSettings.enableBrowsers) {
  programs.chromium = {
    package = pkgs.vivaldi;
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,TouchpadOverscrollHistoryNavigation,AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      "--ozone-platform=wayland"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-hardware-overlays"
    ];
  };

  home.packages = with pkgs; [
    vivaldi-ffmpeg-codecs
  ];
}
