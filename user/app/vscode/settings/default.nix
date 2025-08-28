{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode.profiles.default.userSettings = {
    editor = {
      fontFamily = "JetBrainsMono Nerd Font";
      fontSize = 18;
      fontLigatures = true;
    };

    terminal.integrated.fontFamily = "JetBrainsMono Nerd Font";

    workbench = {
      sideBar.location = "right";
      colorTheme = "Catppuccin Mocha";
      iconTheme = "vscode-icons";
    };

    code-runner = {
      clearPreviousOutput = true;
      runInTerminal = true;
      saveFileBeforeRun = true;
    };

    vim = {
      leader = " ";
      autoIndent = true;
      cursorStylePerMode = let
        cursor = "block";
      in {
        insert = cursor;
        normal = cursor;
        replace = cursor;
        visual = cursor;
        visualblock = cursor;
        visualline = cursor;
      };
      enableNeovim = true;
      neovimConfigPath = builtins.readFile (pkgs.runCommand "nvf-config-path" {
          buildInputs = [inputs.nvf.packages.${pkgs.system}.default];
        } ''
          nvf-print-config-path > $out
        '');
      neovimPath = "${pkgs.neovim-unwrapped}/bin/nvim";
      neovimUseConfigFile = true;
      highlightedyank.enable = true;
      smartRelativeLine = true;
    };

    nix = {
      enableLanguageServer = true;
      serverPath = "nixd";
      serverSettings = {
        nixd.formatting.command = ["alejandra"];
      };
      formatterPath = "alejandra";
    };
  };
}
