{
  programs.nvf.settings = {
    vim.lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspSignature.enable = true;
      lspconfig.enable = true;
      lspsaga.enable = true;
      nvim-docs-view.enable = true;
      lightbulb = {
        enable = true;
        autocmd.enable = true;
      };

      mappings = {
        hover = "<leader>K";
        goToDefinition = "<leader>gd";
        codeAction = "<leader>ca";
        format = "<leader>gf";
      };
    };

    vim.languages = let
      mkDefault = lspServer: {
        enable = true;
        treesitter.enable = true;
        lsp = {
          enable = true;
          server = lspServer;
        };
      };

      mkDefaultFormat = lspServer: formatType:
        mkDefault lspServer
        // {
          format = {
            enable = true;
            type = formatType;
          };
        };
    in {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      enableDAP = true;

      bash =
        mkDefaultFormat "bash-ls" "shfmt"
        // {
          extraDiagnostics.enable = true;
        };

      clang =
        mkDefault "clangd"
        // {
          cHeader = true;
          dap.enable = true;
        };

      csharp = mkDefault "csharp_ls";

      css = mkDefaultFormat "vscode-langservers-extracted" "prettierd";

      dart =
        mkDefault "dart"
        // {
          dap.enable = true;
          flutter-tools = {
            enable = true;
            color.enable = true;
          };
        };

      go =
        mkDefaultFormat "gopls" "gofumpt"
        // {
          dap.enable = true;
        };

      html =
        builtins.removeAttrs (mkDefault "html") ["lsp"]
        // {
          treesitter.autotagHtml = true;
        };

      java =
        mkDefault "jdtls"
        // {
          lsp = builtins.removeAttrs (mkDefault "jdtls").lsp ["server"];
        };

      lua =
        mkDefaultFormat "lua_ls" "stylua"
        // {
          lsp = builtins.removeAttrs (mkDefault "lua_ls").lsp ["server"];
          extraDiagnostics.enable = true;
        };

      markdown =
        mkDefaultFormat "marksman" "prettierd"
        // {
          extensions.render-markdown-nvim.enable = true;
          extraDiagnostics.enable = true;
        };

      nix =
        mkDefaultFormat "nixd" "alejandra"
        // {
          extraDiagnostics.enable = true;
        };

      php = mkDefault "intelephense";

      python =
        mkDefaultFormat "pyright" "black-and-isort"
        // {
          dap.enable = true;
        };

      # rust =
      #   mkDefaultFormat "rust_analyzer" "rustfmt"
      #   // {
      #     lsp = builtins.removeAttrs (mkDefault "rust_analyzer").lsp ["server"];
      #     crates = {
      #       enable = true;
      #       codeActions = true;
      #     };
      #     dap.enable = true;
      #   };

      sql =
        mkDefaultFormat "sqls" "sqlfluff"
        // {
          extraDiagnostics.enable = true;
        };

      svelte =
        mkDefaultFormat "svelte" "prettier"
        // {
          extraDiagnostics.enable = true;
        };

      tailwind = builtins.removeAttrs (mkDefault "tailwindcss-language-server") ["treesitter"];

      terraform =
        mkDefault "terraform-ls"
        // {
          lsp = builtins.removeAttrs (mkDefault "terraform-ls").lsp ["server"];
        };

      ts =
        mkDefaultFormat "ts_ls" "prettierd"
        // {
          extensions.ts-error-translator.enable = true;
          extraDiagnostics.enable = true;
        };

      yaml = mkDefault "yaml-language-server";
    };
  };
}
