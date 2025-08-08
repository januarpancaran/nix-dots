{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = ["quiet" "acpi_backlight=native" "i915.force_probe=46a6" "mem_sleep_default=s2idle" "modprobe.blacklist=iTCO_wdt"];

    initrd.kernelModules = ["i915" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];

    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
    '';

    extraModulePackages = [config.boot.kernelPackages.nvidiaPackages.stable];
  };
}
