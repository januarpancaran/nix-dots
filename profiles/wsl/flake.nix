{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS-WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nvf
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim Plugins
    none-ls-extras-nvim = {
      url = "github:nvimtools/none-ls-extras.nvim";
      flake = false;
    };

    # Zsh Plugins
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
        hostname = "nixos";
        profile = "wsl";
        flakeDir = "/home/" + userSettings.username + "/.dotfiles/profiles/" + systemSettings.profile;
      };

      userSettings = {
        username = "daangsangu";
        defaultShell = "zsh"; # or bash
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
          inputs.nixos-wsl.nixosModules.default
          ./configuration.nix
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
          inputs.catppuccin.homeModules.catppuccin
          inputs.nvf.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
