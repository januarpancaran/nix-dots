{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
  ];

  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        swtpm.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
        vhostUserPackages = [pkgs.virtiofsd];
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
