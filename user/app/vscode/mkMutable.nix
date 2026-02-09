{ config, lib, ... }:
let
  vscodeVariants = [ "Code" ];

  mkUserDir = name: "${config.xdg.configHome}/${name}/User";

  filesToMakeMutable = lib.flatten (
    map (
      name:
      let
        userDir = mkUserDir name;
      in
      [
        "${userDir}/settings.json"
        "${userDir}/keybindings.json"
      ]
    ) vscodeVariants
  );

  makeMutable = file: ''
    target="$HOME/${file}"
    if [ -L "$target" ]; then
      src=$(readlink "$target")
      rm "$target"
      cp "$src" "$target"
      chmod u+w "$target"
    elif [ -f "$target" ]; then
      chmod u+w "$target"
    fi
  '';
in
{
  home.activation.vscodeMutable = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${lib.concatMapStrings makeMutable filesToMakeMutable}
  '';
}
