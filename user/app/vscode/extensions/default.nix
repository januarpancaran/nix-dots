{pkgs, ...}: {
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    # Better Comment
    "aaron-bond.better-comments"

    # C/C++
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.makefile-tools"

    # C#
    "ms-dotnettools.csharp"
    "ms-dotnettools.csdevkit"

    # Css
    "pranaygp.vscode-css-peek"
    "stylelint.vscode-stylelint"
    "zignd.html-css-class-completion"

    # Code Runner
    "formulahendry.code-runner"

    # Devbox
    "jetpack-io.devbox"

    # Docker
    "ms-azuretools.vscode-docker"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "ms-vscode-remote.remote-containers"

    # DotEnv
    "mikestead.dotenv"

    # Eslint
    "dbaeumer.vscode-eslint"

    # Error Lens
    "usernamehw.errorlens"

    # Git
    "eamodio.gitlens"
    "github.vscode-github-actions"
    "github.vscode-pull-request-github"

    # Golang
    "golang.go"

    # GraphQL
    "graphql.vscode-graphql"
    "graphql.vscode-graphql-syntax"

    # HTML
    "ecmel.vscode-html-css"

    # Import Cost
    "wix.vscode-import-cost"

    # Indent Rainbow
    "oderwat.indent-rainbow"

    # Java
    "redhat.java"
    "vscjava.vscode-gradle"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-pack"
    "vscjava.vscode-java-test"
    "vscjava.vscode-maven"

    # JS/TS
    "xabikos.javascriptsnippets"
    "wallabyjs.quokka-vscode"

    # Jupyter
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.vscode-jupyter-slideshow"

    # Markdown
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"

    # Neovim
    "asvetliakov.vscode-neovim"

    # Nix
    "jnoortheen.nix-ide"

    # Path Intellisense
    "christian-kohler.path-intellisense"

    # PHP
    "devsense.phptools-vscode"
    "devsense.composer-php-vscode"
    "devsense.profiler-php-vscode"
    "devsense.intelli-php-vscode"

    # Prettier
    "esbenp.prettier-vscode"

    # Python
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.debugpy"
    "ms-python.isort"
    "ms-python.black-formatter"
    "ms-python.pylint"

    # Rust
    "rust-lang.rust-analyzer"

    # Stylua
    "johnnymorganz.stylua"

    # SQL
    "cweijan.dbclient-jdbc"
    "cweijan.vscode-mysql-client2"

    # Svelte
    "svelte.svelte-vscode"

    # Tailwind
    "bradlc.vscode-tailwindcss"

    # Terraform
    "hashicorp.terraform"

    # Theme
    "catppuccin.catppuccin-vsc"
    "catppuccin.catppuccin-vsc-icons"

    # Unity
    "visualstudiotoolsforunity.vstuc"

    # Vue
    "vue.volar"

    # Vscode pdf
    "tomoki1207.pdf"

    # Yaml
    "redhat.vscode-yaml"
  ];
}
