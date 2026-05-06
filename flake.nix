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

    # Noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
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

        /**
          * Optional Features
          *
          * enableSteam: Install steam
          * enableDocker: Install docker
          * enableFlatpak: Install and Setup flatpak
          * enableMySQL: Install MySQL service
          * enablePostgreSQL: Install PostgreSQL service
          * enableVM: Install Virtual Machine via qemu and virt-manager
        */
        enableSteam = false;
        enableDocker = true;
        enableFlatpak = true;
        enableMySQL = true;
        enablePostgreSQL = true;
        enableVM = false;
      };

      userSettings = {
        username = "daangsangu";
        defaultShell = "zsh"; # or bash
        githubUsername = "januarpancaran";
        githubEmail = "januar352@gmail.com";

        /**
          * Optional Features
          *
          * enableFirefox: Enables Firefox, enables Google Chrome if false
          * enableProgrammingPkgs: Install all programming packages stated in profiles/home
        */
        enableFirefox = true;
        enableProgrammingPkgs = true;
      };

      pkgs = import inputs.nixpkgs {
        inherit (systemSettings) system;

        config = {
          allowUnfree = true;
          allowBroken = false;
        };

        overlays = [
          inputs.niri.overlays.niri
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
          inputs.noctalia.homeModules.default
          inputs.catppuccin.homeModules.catppuccin
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
        ];
      };
    };
}
