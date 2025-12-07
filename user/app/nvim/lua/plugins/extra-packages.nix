{pkgs, ...}: {
  programs.neovim.extraPackages = with pkgs; [
    # lsp
    bash-language-server
    clang-tools
    cmake-language-server
    gopls
    intelephense
    jdt-language-server
    lua-language-server
    marksman
    nixd
    pyright
    rust-analyzer
    sqls
    svelte-language-server
    tailwindcss-language-server
    terraform-ls
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server

    # none-ls
    alejandra
    black
    blade-formatter
    gofumpt
    google-java-format
    isort
    php84Packages.php-cs-fixer
    prettier
    prettierd
    rustfmt
    shfmt
    sqlfluff
    stylua

    # others
    nodejs
  ];
}
