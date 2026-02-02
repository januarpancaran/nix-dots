{ pkgs, ... }:
{
  imports = [
    ./lua/plugins
  ];

  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    initLua = ''
      ${builtins.readFile ./lua/config/options.lua}
      ${builtins.readFile ./lua/config/mappings.lua}
    '';
  };
}
