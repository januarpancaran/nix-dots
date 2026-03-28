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
    ../../user/app/hyprlock
    ../../user/app/mpv
    ../../user/app/nvim
    ../../user/app/opencode-antigravity-auth
    ../../user/app/terminal/ghostty.nix
    ../../user/app/wlogout
    ../../user/inputs/fcitx5.nix
    ../../user/services/hypridle.nix
    ../../user/services/swww.nix
    ../../user/services/systemd-services.nix
    ../../user/services/systemd-timers.nix
    ../../user/services/xdg-portal.nix
    ../../user/shell/bash.nix
    ../../user/shell/shell-utils/fastfetch.nix
    ../../user/shell/shell-utils/starship
    ../../user/shell/shell-utils/tmux.nix
    ../../user/shell/zsh.nix

    (
      if userSettings.enableFirefox then
        ../../user/app/browser/firefox
      else
        ../../user/app/browser/google-chrome
    )
  ]
  ++ (
    if userSettings.wm == "niri" then
      [
        ../../user/app/eww
        ../../user/app/fuzzel
        ../../user/services/mako
        ../../user/wm/niri
      ]
    else
      [
        ../../user/app/rofi
        ../../user/app/waybar
        ../../user/services/dunst
        ../../user/wm/hyprland
      ]
  );

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
      foliate
      fzf
      glib
      htop
      libreoffice
      loupe
      papers
      postman
      ripgrep
      telegram-desktop
      tree
      unrar
      unzip
      wget
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
