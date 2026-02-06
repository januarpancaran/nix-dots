{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    none-ls-extras-nvim = {
      url = "github:nvimtools/none-ls-extras.nvim";
      flake = false;
    };

    # Zsh plugins
    zsh-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "hayudaang";
        profile = "personal";
        bootloader = "grub";
        bootloaderDevice = [ "nodev" ];
        bootloaderEfiMountPoint = "/boot/efi";
        timeZone = "Asia/Jakarta";
        flakeDir = "/home/" + userSettings.username + "/.dotfiles";
      };

      userSettings = {
        username = "daangsangu";
        wm = "niri"; # or Hyprland
        defaultShell = "zsh"; # or bash
        defaultBrowser = "zen"; # or chrome
        claudeCodeModel = "claude"; # or gemini
        githubUsername = "januarpancaran";
        githubEmail = "januar352@gmail.com";
      };

      pkgs = import inputs.nixpkgs {
        inherit (systemSettings) system;

        config = {
          allowUnfree = true;
          allowBroken = false;
        };

        overlays = [
          inputs.niri.overlays.niri
          (final: prev: {
            antigravity-claude-proxy = prev.buildNpmPackage {
              pname = "antigravity-claude-proxy";
              version = "2.4.4";

              src = prev.fetchFromGitHub {
                owner = "badrisnarayanan";
                repo = "antigravity-claude-proxy";
                rev = "v2.4.4";
                hash = "sha256-HN+1a/SK6QudAcF6AnxcPRZLAIazOatnCC5zEp1v65s=";
              };

              npmDepsHash = "sha256-HSvcf/xwRG4LXQjIDykVQVJNvabMvT7JGt8tL4k1OgM=";
              dontNpmBuild = true;

              meta = with prev.lib; {
                description = "Antigravity Claude Proxy";
                license = licenses.mit;
                platforms = platforms.linux;
              };
            };
          })
        ];
      };
    in
    {
      nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
        inherit (systemSettings) system;

        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };

        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
        ];
      };

      homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };

        modules = [
          inputs.niri.homeModules.niri
          inputs.catppuccin.homeModules.catppuccin
          inputs.nvf.homeManagerModules.default
          inputs.zen-browser.homeModules.beta
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
        ];
      };
    };
}
