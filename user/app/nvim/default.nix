{ pkgs, ... }:
{
  imports = [
    # ./lua/plugins
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withRuby = true;

    initLua = ''
      ${builtins.readFile ./lua/config/options.lua}
      ${builtins.readFile ./lua/config/mappings.lua}
    '';
  };
}
