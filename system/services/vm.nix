{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enableVM {
  environment.systemPackages = with pkgs; [
    qemu
  ];

  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
