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

    # Zsh Plugins
    zsh-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
  };

  outputs = {self, ...} @ inputs: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixos";
      profile = "wsl";
      flakeDir = "/home/" + userSettings.username + "/.dotfiles/profiles/" + systemSettings.profile;
    };

    userSettings = {
      username = "daangsangu";
      githubUsername = "januarpancaran";
      githubEmail = "januar352@gmail.com";
    };

    pkgs = import inputs.nixpkgs {
      inherit (systemSettings) system;

      config = {
        allowUnfree = true;
        allowBroken = false;
      };
    };
  in {
    nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
      inherit (systemSettings) system;

      specialArgs = {
        inherit inputs;
        inherit systemSettings;
        inherit userSettings;
      };

      modules = [
        inputs.nixos-wsl.nixosModules.default
        {
          system.stateVersion = "25.05";
          wsl.enable = true;
        }
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
