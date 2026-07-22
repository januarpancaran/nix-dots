{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    curl
    ffmpegthumbnailer
    fzf
    glib
    htop
    icu
    jq
    neovim
    ripgrep
    tree
    tumbler
    unrar
    unzip
    wget
    wl-clipboard
    yazi
    zip
    zoxide
  ];
}
