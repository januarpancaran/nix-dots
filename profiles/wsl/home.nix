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
    ../../user/app/npm
    ../../user/app/vim
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
      curl
      fzf
      glib
      htop
      jq
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
