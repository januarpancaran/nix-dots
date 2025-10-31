{pkgs, ...}: {
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    font-awesome_4
    font-awesome_5
    liberation_ttf
    material-symbols
    meslo-lgs-nf
    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    terminus_font
  ];
}
