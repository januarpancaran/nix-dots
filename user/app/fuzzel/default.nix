{ pkgs, ... }:
{
  programs.fuzzel = {
    package = pkgs.fuzzel;
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=10";
        dpi-aware = "yes";
        prompt = ">> ";
        icon-theme = "Tela-nord-dark";
        icons-enabled = "yes";
        fields = "filename,name,generic";
        fuzzy = "no";
        show-actions = "no";

        lines = 20;
        width = 50;
        horizontal-pad = 50;
        vertical-pad = 15;
        inner-pad = 5;

        image-size-ratio = 0.8;

        layer = "top";
        exit-on-keyboard-focus-loss = "yes";
      };

      colors = {
        background = "282a36dd";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection-match = "8be9fdff";
        selection = "44475add";
        selection-text = "f8f8f2ff";
        border = "bd93f9ff";
      };

      border = {
        width = 1;
        radius = 10;
      };

      dmenu = {
        mode = "text";
        exit-immediately-if-empty = "no";
      };
    };
  };
}
