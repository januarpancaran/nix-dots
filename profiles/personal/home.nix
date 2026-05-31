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
    ../../user/app/terminal/ghostty.nix
    ../../user/app/vim
    ../../user/app/vscode
    ../../user/services/gnome-keyring.nix
    ../../user/services/gpg-agent.nix
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
      DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
      DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
      PSHOME = "${pkgs.powershell}/lib/powershell";
      POWERSHELL_TELEMETRY_OPTOUT = "1";
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
      icu
      jq
      loupe
      nautilus
      neovim
      obs-studio
      onlyoffice-desktopeditors
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
        bun
        cargo
        dotnet-sdk_10
        dbeaver-bin
        gcc
        github-cli
        github-copilot-cli
        gmp
        gnumake
        go
        google-antigravity
        jetbrains.idea
        jetbrains.jdk
        kiro-cli
        kotlin
        libyaml
        lua
        ngrok
        nixd
        nssTools
        nodejs
        opencode
        openssl
        php
        php84Packages.composer
        pkg-config
        python3
        powershell
        ruby_4_0
        rustc
        spring-boot-cli
        uv
        zlib
      ]
    );

  programs.home-manager.enable = true;
}
