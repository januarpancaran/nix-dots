{
  lib,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (builtins.elem "brave-origin" userSettings.enableBrowsers) {
  programs.chromium = {
    package = pkgs.brave-origin;
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,TouchpadOverscrollHistoryNavigation,AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      "--ozone-platform=wayland"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-hardware-overlays"
    ];
  };
}
