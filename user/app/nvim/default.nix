{pkgs, ...}: {
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./lua/config/mappings.lua}
      ${builtins.readFile ./lua/config/options.lua}
    '';
  };
}
