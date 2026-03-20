{
  lib,
  pkgs,
  userSettings,
  ...
}:
{
  imports = [
    ../../theme
    ../../user/app/git
    ../../user/app/nvim
    ../../user/app/opencode-antigravity-auth
    ../../user/shell/bash.nix
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/zsh.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  home.packages =
    with pkgs;
    [
      bat
      curl
      fzf
      glib
      htop
      ripgrep
      tree
      unrar
      unzip
      wget
      wl-clipboard
      yazi
      zip
      zoxide
    ]
    ++ lib.optionals userSettings.enableProgrammingPkgs (
      with pkgs;
      [
        bun
        cargo
        dotnet-sdk_10
        gcc
        github-cli
        github-copilot-cli
        gmp
        gnumake
        go
        jdk25
        kotlin
        libyaml
        lua
        ngrok
        nixd
        nodejs
        opencode
        openssl
        php
        php84Packages.composer
        pkg-config
        ruby
        rustc
        spring-boot-cli
        zlib

        (python3.withPackages (
          ps: with ps; [
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
          ]
        ))
      ]
    );

  programs.home-manager.enable = true;
}
