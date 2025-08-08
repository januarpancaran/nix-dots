{userSettings, ...}: {
  services = {
    getty.autologinUser = userSettings.username;
    printing.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
  };
}
