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

        /**
          * Optional Features
          *
          * enableDocker: Install docker
          * enableFlatpak: Install and Setup flatpak
          * enableMySQL: Install MySQL service
          * enablePostgreSQL: Install PostgreSQL service
        */
        enableDocker = true;
        enableFlatpak = true;
        enableMySQL = true;
        enablePostgreSQL = true;
      };

      userSettings = {
        username = "daangsangu";
        defaultShell = "zsh"; # or bash
        githubUsername = "januarpancaran";
        githubEmail = "januar352@gmail.com";

        /**
          * Optional Features
          *
          * enableProgrammingPkgs: Install all programming packages stated in profiles/home
          * enableClaudeModel: Enables claude model for Claude Code
          * enableGeminiModel: Enables gemini model for Claude Code
        */
        enableProgrammingPkgs = true;
        enableClaudeModel = true;
        enableGeminiModel = false;
      };

      pkgs = import inputs.nixpkgs {
        inherit (systemSettings) system;

        config = {
          allowUnfree = true;
          allowBroken = false;
        };
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
          ./home.nix
        ];
      };
    };
}
