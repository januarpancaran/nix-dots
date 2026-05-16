{
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
lib.mkIf systemSettings.enableAndroidDev {
  nixpkgs.config.android_sdk.accept_license = true;

  users.users.${userSettings.username}.extraGroups = [ "kvm" ];

  environment.sessionVariables = {
    ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1";
  };

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];
}
