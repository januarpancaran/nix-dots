{ pkgs, ... }:
{
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    # Container
    "ms-azuretools.vscode-docker"
    "ms-vscode-remote.remote-containers"
    "ms-vscode.hexeditor"

    # C/C++
    "ms-vscode.cmake-tools"
    "ms-vscode.cpp-devtools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"

    # C#
    "ms-dotnettools.csdevkit"
    "ms-dotnettools.csharp"
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-vscode.powershell"

    # Go
    "golang.go"

    # HTML/CSS
    "bradlc.vscode-tailwindcss"
    "davidanson.vscode-markdownlint"
    "ecmel.vscode-html-css"
    "formulahendry.auto-rename-tag"
    "pranaygp.vscode-css-peek"

    # Java
    "redhat.java"
    "vmware.vscode-boot-dev-pack"
    "vmware.vscode-spring-boot"
    "vscjava.vscode-gradle"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-dependency"
    "vscjava.vscode-java-pack"
    "vscjava.vscode-java-test"
    "vscjava.vscode-maven"
    "vscjava.vscode-spring-boot-dashboard"
    "vscjava.vscode-spring-initializr"

    # JS/TS
    "angular.ng-template"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "svelte.svelte-vscode"
    "vue.volar"

    # Markdown
    "shd101wyy.markdown-preview-enhanced"
    "yzhang.markdown-all-in-one"

    # PHP
    "devsense.composer-php-vscode"
    "devsense.intelli-php-vscode"
    "devsense.phptools-vscode"
    "devsense.profiler-php-vscode"

    # Python
    "ms-python.black-formatter"
    "ms-python.debugpy"
    "ms-python.isort"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.vscode-jupyter-slideshow"

    # Ruby
    "ninoseki.vscode-mogami"
    "setobiralo.erb-commenter"
    "shopify.ruby-extensions-pack"
    "shopify.ruby-lsp"
    "sorbet.sorbet-vscode-extension"

    # Rust
    "rust-lang.rust-analyzer"

    # Themes
    "catppuccin.catppuccin-vsc-icons"
    "mvllow.rose-pine"
    "vscode-icons-team.vscode-icons"

    # Others
    "aaron-bond.better-comments"
    "adpyke.codesnap"
    "asvetliakov.vscode-neovim"
    "christian-kohler.path-intellisense"
    "codezombiech.gitignore"
    "dotjoshjohnson.xml"
    "editorconfig.editorconfig"
    "formulahendry.auto-close-tag"
    "formulahendry.code-runner"
    "github.vscode-github-actions"
    "hashicorp.terraform"
    "humao.rest-client"
    "mechatroner.rainbow-csv"
    "mikestead.dotenv"
    "oderwat.indent-rainbow"
    "redhat.vscode-xml"
    "redhat.vscode-yaml"
    "tamasfe.even-better-toml"
    "tomoki1207.pdf"
    "usernamehw.errorlens"
    "wix.vscode-import-cost"
  ];
}
