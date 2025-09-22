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

    # Nvf
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix4vscode
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
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

  outputs = {self, ...} @ inputs: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "hayudaang";
      profile = "personal";
      bootloader = "grub";
      bootloaderDevice = ["nodev"];
      bootloaderEfiMountPoint = "/boot/efi";
      timeZone = "Asia/Jakarta";
      flakeDir = "/home/" + userSettings.username + "/.dotfiles";
    };

    userSettings = {
      username = "daangsangu";
      wm = "niri"; # of "Hyprland"
      nvimFlavour = "nvim"; # or nvf
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
        inputs.nix4vscode.overlays.default
      ];
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
        (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
      ];
    };
  };
}
