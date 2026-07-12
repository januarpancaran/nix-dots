{ pkgs, lib, ... }:
let
  # Keep this list in sync with `system/fonts/default.nix`.
  # OnlyOffice DesktopEditors does not use fontconfig to discover fonts -
  # it only scans /usr/share/fonts and ~/.local/share/fonts directly, both
  # of which are empty/nonexistent by default on NixOS. See:
  # https://wiki.nixos.org/wiki/Onlyoffice
  onlyofficeFontPkgs = with pkgs; [
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
in
{
  home.packages = [ pkgs.onlyoffice-desktopeditors ];

  # OnlyOffice hardcodes its font search to /usr/share/fonts and
  # ~/.local/share/fonts instead of asking fontconfig, so on NixOS it sees
  # no fonts at all. Work around this by copying (not symlinking, since the
  # files need to be writable/world-readable, not the read-only Nix store
  # permissions) the fonts we already install into ~/.local/share/fonts on
  # every activation.
  home.activation.onlyofficeFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    fontDir="$HOME/.local/share/fonts"
    run mkdir -p "$fontDir"

    for src in ${lib.concatStringsSep " " onlyofficeFontPkgs}; do
      if [ -d "$src/share/fonts" ]; then
        run find "$src/share/fonts" -type f \
          \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) \
          -exec cp -f -t "$fontDir" {} +
      fi
    done

    run chmod -R u+rw,go+r,go-w "$fontDir"
    run find "$fontDir" -type d -exec chmod 755 {} \;
  '';
}
