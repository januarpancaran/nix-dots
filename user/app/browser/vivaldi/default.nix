{
  lib,
  pkgs,
  userSettings,
  ...
}:
lib.mkIf (builtins.elem "vivaldi" userSettings.enableBrowsers) {
  programs.chromium = {
    package = pkgs.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    };
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
