{
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    ../../theme
    ../../user/app/antigravity-claude-proxy
    ../../user/app/git
    ../../user/app/opencode-antigravity-auth
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/bash.nix
    ../../user/shell/zsh.nix

    (
      if userSettings.nvimFlavour == "nvf"
      then ../../user/app/nvf
      else ../../user/app/nvim
    )
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {EDITOR = "nvim";};
  };

  home.packages = with pkgs; [
    bat
    curl
    devbox
    fzf
    glib
    htop
    mailhog
    meilisearch
    ripgrep
    tree
    unrar
    unzip
    wget
    wl-clipboard
    yazi
    zip
    zoxide

    alejandra
    bun
    claude-code
    dotnet-aspnetcore
    dotnet-sdk
    dotnet-runtime
    gcc
    go
    jdk
    lua
    ngrok
    nixd
    nodejs
    opencode
    php
    php84Packages.composer
    (python3.withPackages (ps:
      with ps; [
        numpy
        pandas
        matplotlib
        seaborn
        scikit-learn
        streamlit
        fastapi
        pydantic
        uvicorn
        flask
        flask-cors
        django
        django-cors-headers
      ]))
  ];

  programs.home-manager.enable = true;
}
