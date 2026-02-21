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
      if userSettings.enableZenBrowser then
        ../../user/app/browser/zen-browser
      else
        ../../user/app/browser/brave
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
      devbox
      foliate
      fzf
      glib
      htop
      insomnia
      libreoffice
      loupe
      papers
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
        antigravity
        kiro
        opencode-desktop
        sqlitebrowser
        vscode

        bun
        dotnet-sdk
        gcc
        github-cli
        github-copilot-cli
        go
        jdk
        lua
        ngrok
        nixd
        nodejs
        opencode
        php
        php84Packages.composer
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
