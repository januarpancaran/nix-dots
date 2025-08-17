{pkgs, ...}: {
  programs.vscode.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    # AWS
    "amazonwebservices.aws-toolkit-vscode"

    # Better Comment
    "aaron-bond.better-comments"

    # C/C++
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.makefile-tools"

    # C#
    "ms-dotnettools.csdevkit"

    # Css
    "pranaygp.vscode-css-peek"
    "stylelint.vscode-stylelint"
    "zignd.html-css-class-completion"

    # Code Runner
    "formulahendry.code-runner"

    # Dart
    "dart-code.dart-code"
    "dart-code.flutter"

    # Devbox
    "jetpack-io.devbox"

    # Docker
    "ms-azuretools.vscode-docker"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "ms-vscode-remote.remote-containers"

    # DotEnv
    "mikestead.dotenv"

    # Drawio
    "hediet.vscode-drawio"

    # Eslint
    "dbaeumer.vscode-eslint"

    # Error Lens
    "usernamehw.errorlens"

    # Git
    "eamodio.gitlens"
    "github.copilot"
    "github.copilot-chat"
    "github.vscode-github-actions"
    "github.vscode-pull-request-github"

    # Golang
    "golang.go"

    # GraphQL
    "graphql.vscode-graphql"
    "graphql.vscode-graphql-syntax"

    # HTML
    "ecmel.vscode-html-css"
    "formulahendry.auto-close-tag"
    "formulahendry.auto-rename-tag"

    # Import Cost
    "wix.vscode-import-cost"

    # Indent Rainbow
    "oderwat.indent-rainbow"

    # Intellicode
    "visualstudioexptteam.vscodeintellicode"
    "visualstudioexptteam.intellicode-api-usage-examples"

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

    # Live Server
    "ritwickdey.liveserver"
    "ms-vsliveshare.vsliveshare"
    "ms-vscode.live-server"

    # Markdown
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"

    # Nix
    "jnoortheen.nix-ide"

    # Path Intellisense
    "christian-kohler.path-intellisense"

    # PHP
    "bmewburn.vscode-intelephense-client"
    "xdebug.php-pack"
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
    "vscode-icons-team.vscode-icons"
    "github.github-vscode-theme"
    "dracula-theme.theme-dracula"
    "catppuccin.catppuccin-vsc"

    # Thunder Client
    "rangav.vscode-thunder-client"

    # Unity
    "visualstudiotoolsforunity.vstuc"

    # Vim
    "vscodevim.vim"

    # Vue
    "vue.volar"

    # Vscode pdf
    "tomoki1207.pdf"

    # Yaml
    "redhat.vscode-yaml"
  ];
}
