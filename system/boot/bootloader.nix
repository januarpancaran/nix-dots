{
  lib,
  systemSettings,
  ...
}:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = lib.mkDefault true;
        efiSysMountPoint = systemSettings.bootloaderEfiMountPoint;
      };

      grub = {
        enable = lib.mkDefault (systemSettings.bootloader == "grub");
        devices = systemSettings.bootloaderDevice;
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };

      systemd-boot.enable = lib.mkDefault (systemSettings.bootloader == "systemd-boot");

      limine = {
        enable = lib.mkDefault (systemSettings.bootloader == "limine");
        efiSupport = true;
        secureBoot.enable = true;
      };

      timeout = 5;
    };
  };
}
