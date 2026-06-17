{
  lib,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (!userSettings.enableFirefox) {
  programs.chromium = {
    package = pkgs.google-chrome;
    enable = true;

    commandLineArgs = [
      "--enable-features=UseOzonePlatform,TouchpadOverscrollHistoryNavigation,AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-hardware-overlays"
    ];
  };
}
