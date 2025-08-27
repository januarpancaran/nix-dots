{pkgs, ...}: {
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
      neovimConfigPath = let
        nvfConfig = pkgs.writeShellScriptBin "nvf-config-path" ''
          exec $(nvf-print-config-path)
        '';
      in "${nvfConfig}/bin/nvf-config-path";
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
