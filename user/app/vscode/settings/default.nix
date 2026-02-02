{
  pkgs,
  inputs,
  ...
}:
{
  programs.vscode.profiles.default = {
    userSettings = {
      editor = {
        fontFamily = "JetBrainsMono Nerd Font";
        fontSize = 18;
        fontLigatures = true;
        formatOnSave = true;
        lineNumbers = "relative";
        autoClosingBrackets = "never";
        autoClosingQuotes = "never";
      };

      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";

      workbench = {
        sideBar.location = "right";
        secondarySideBar.defaultVisibility = "hidden";
        colorTheme = "Catppuccin Mocha";
        iconTheme = "catppuccin-mocha";
      };

      code-runner = {
        clearPreviousOutput = true;
        runInTerminal = true;
        saveFileBeforeRun = true;
      };

      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };

      "git.autofetch" = true;

      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "[lua]" = {
        "editor.defaultFormatter" = "JohnnyMorganz.stylua";
      };

      nix = {
        enableLanguageServer = true;
        serverPath = "nixd";
        serverSettings = {
          nixd.formatting.command = [ "alejandra" ];
        };
        formatterPath = "alejandra";
      };

      "redhat.telemetry.enabled" = false;
    };

    keybindings = [
      {
        key = "enter";
        command = "acceptSelectedSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+n";
        command = "selectNextSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+p";
        command = "selectPrevSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+d";
        command = "scrollDown";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+f";
        command = "scrollUp";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+space";
        command = "triggerSuggest";
      }
      {
        key = "ctrl+e";
        command = "hideSuggestWidget";
        when = "suggestWidgetVisible";
      }
      {
        key = "tab";
        command = "selectNextSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "tab";
        command = "jumpToNextSnippetPlaceholder";
        when = "editorTextFocus && hasSnippetCompletions";
      }
      {
        key = "shift+tab";
        command = "selectPrevSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "shift+tab";
        command = "jumpToPrevSnippetPlaceholder";
        when = "editorTextFocus && hasSnippetCompletions";
      }
    ];
  };
}
