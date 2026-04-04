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
    ../../user/app/mpv
    ../../user/app/noctalia
    ../../user/app/npm
    ../../user/app/nvim
    ../../user/app/terminal/ghostty.nix
    ../../user/inputs/fcitx5.nix
    ../../user/services/xdg-portal.nix
    ../../user/shell/bash.nix
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/zsh.nix
    ../../user/wm/niri

    (
      if userSettings.enableFirefox then
        ../../user/app/browser/firefox
      else
        ../../user/app/browser/google-chrome
    )
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
      brightnessctl
      curl
      discord
      foliate
      fzf
      glib
      gnome-control-center
      htop
      jq
      libreoffice
      loupe
      nautilus
      obs-studio
      papers
      ripgrep
      spotify
      telegram-desktop
      tree
      unrar
      unzip
      wget
      wl-clipboard
      yazi
      zip
      zotero
      zoxide
    ]
    ++ lib.optionals userSettings.enableProgrammingPkgs (
      with pkgs;
      [
        opencode
        vscode

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
        openssl
        php
        php84Packages.composer
        pkg-config
        ruby_4_0
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
