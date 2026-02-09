{ pkgs, ... }:
{
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    # === AI / Copilot ===
    "github.copilot-chat"

    # === Jupyter / Python ===
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-slideshow"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.debugpy"
    "ms-python.isort"
    "ms-python.black-formatter"
    "ms-python.vscode-python-envs"

    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-vscode.cpptools"

    # === Java ===
    "redhat.java"
    "vscjava.vscode-java-pack"
    "vscjava.vscode-java-dependency"
    "vscjava.vscode-maven"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-test"
    "vscjava.vscode-gradle"
    "vscjava.vscode-spring-initializr"
    "vmware.vscode-spring-boot"

    # === Web / Frontend ===
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "bradlc.vscode-tailwindcss"
    "angular.ng-template"
    "vue.volar"
    "ecmel.vscode-html-css"
    "pranaygp.vscode-css-peek"
    "wix.vscode-import-cost"
    "svelte.svelte-vscode"

    # === DevOps / Containers ===
    "ms-azuretools.vscode-docker"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "ms-vscode-remote.remote-containers"
    "ms-azuretools.vscode-containers"

    # === .NET ===
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-dotnettools.csharp"
    "ms-dotnettools.csdevkit"

    # === PHP ===
    "devsense.phptools-vscode"
    "devsense.intelli-php-vscode"
    "devsense.composer-php-vscode"
    "devsense.profiler-php-vscode"

    # === Go ===
    "golang.go"

    # === Rust ===
    "rust-lang.rust-analyzer"

    # === PowerShell ===
    "ms-vscode.powershell"

    # === Git ===
    "eamodio.gitlens"

    # === Editor UX ===
    "asvetliakov.vscode-neovim"
    "usernamehw.errorlens"
    "christian-kohler.path-intellisense"
    "xabikos.javascriptsnippets"
    "oderwat.indent-rainbow"
    "aaron-bond.better-comments"
    "formulahendry.code-runner"

    # === Markdown / Docs ===
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"
    "tomoki1207.pdf"

    # === Config / Env ===
    "redhat.vscode-yaml"
    "mikestead.dotenv"
    "tamasfe.even-better-toml"
    "redhat.vscode-xml"

    # === Formatting / Lua ===
    "johnnymorganz.stylua"

    # === Themes ===
    "enkia.tokyo-night"
    "catppuccin.catppuccin-vsc"
    "catppuccin.catppuccin-vsc-icons"
  ];
}
