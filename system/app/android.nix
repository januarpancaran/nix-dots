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
    # Prefer the emulator's bundled runtime; forcing system libs on Nix often breaks Qt/emulator libs.
    ANDROID_HOME = "/home/${userSettings.username}/Android/Sdk";
    ANDROID_SDK_ROOT = "/home/${userSettings.username}/Android/Sdk";
    ANDROID_USER_HOME = "/home/${userSettings.username}/.android";
    ANDROID_AVD_HOME = "/home/${userSettings.username}/.android/avd";
    ANDROID_EMULATOR_HOME = "/home/${userSettings.username}/.android";
  };

  environment.systemPackages = with pkgs; [
    android-studio
  ];
}
