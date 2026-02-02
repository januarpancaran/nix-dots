{ pkgs, ... }:
{
  programs.neovim.extraPackages = with pkgs; [
    # Lsp
    bash-language-server
    clang-tools
    cmake-language-server
    vscode-langservers-extracted
    gopls
    intelephense
    jdt-language-server
    lua-language-server
    marksman
    nixd
    omnisharp-roslyn
    pyright
    rust-analyzer
    svelte-language-server
    tailwindcss-language-server
    terraform-ls
    typescript-language-server
    yaml-language-server

    # formatter
    black
    blade-formatter
    csharpier
    gofumpt
    google-java-format
    nixfmt
    isort
    php84Packages.php-cs-fixer
    prettierd
    rustfmt
    shfmt
    stylua
  ];
}
