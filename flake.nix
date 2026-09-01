{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS-WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  };

  outputs =
    { self, ... }@inputs:
    let
      # ── Shared user settings ────────────────────────────────────────────────
      userSettings = {
        username = "daangsangu";
        defaultShell = "zsh"; # or bash
        gitUsername = "Januar Pancaran";
        gitEmail = "januar352@gmail.com";

        /**
          * Optional Features
          *
          * enableBrowsers: List browsers to install, currently only "firefox", "google-chrome", and "vivaldi" are supported
          * defaultBrowser: Choose a default browser from the former list
          * enableProgrammingPkgs: Install all programming packages stated in user/packages/programming.nix
        */
        enableBrowsers = [
          "firefox"
        ];
        defaultBrowser = "firefox";
        enableProgrammingPkgs = true;
      };

      # ── Personal (desktop) settings ─────────────────────────────────────────
      personalSettings = {
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
          * enableContainers: Install containers using podman
          * enableFlatpak: Install and setup flatpak
          * enableMySQL: Install MySQL service
          * enablePostgreSQL: Install PostgreSQL service
          * enableVM: Install Virtual Machine via qemu and virt-manager
          * enableAndroidDev: Install Android Studio + emulator runtime support
        */
        enableSteam = true;
        enableContainers = true;
        enableFlatpak = true;
        enableMySQL = true;
        enablePostgreSQL = true;
        enableVM = false;
        enableAndroidDev = true;
      };

      # ── WSL settings ────────────────────────────────────────────────────────
      wslSettings = {
        system = "x86_64-linux";
        hostname = "hayudaang";
        profile = "wsl";
        timeZone = "Asia/Jakarta";
        flakeDir = "/home/" + userSettings.username + "/.dotfiles";

        /**
          * Optional Features
          *
          * enableContainers: Install containers using podman
          * enableMySQL: Install MySQL service
          * enablePostgreSQL: Install PostgreSQL service
        */
        enableContainers = true;
        enableMySQL = true;
        enablePostgreSQL = true;
      };

      # ── Package sets ────────────────────────────────────────────────────────
      mkPkgs =
        system: extraOverlays:
        import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowBroken = false;
          };
          overlays = extraOverlays;
        };

      personalPkgs = mkPkgs personalSettings.system [
        (import ./overlays/onlyoffice.nix)
      ];
      wslPkgs = mkPkgs wslSettings.system [ ];
    in
    {
      # ── NixOS configurations ────────────────────────────────────────────────

      nixosConfigurations.personal = inputs.nixpkgs.lib.nixosSystem {
        inherit (personalSettings) system;
        specialArgs = {
          inherit inputs;
          systemSettings = personalSettings;
          inherit userSettings;
        };
        modules = [
          ./profiles/personal/configuration.nix
        ];
      };

      nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
        inherit (wslSettings) system;
        specialArgs = {
          inherit inputs;
          systemSettings = wslSettings;
          inherit userSettings;
        };
        modules = [
          inputs.nixos-wsl.nixosModules.default
          ./profiles/wsl/configuration.nix
        ];
      };

      # ── Home Manager configurations ─────────────────────────────────────────

      homeConfigurations.personal = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = personalPkgs;
        extraSpecialArgs = {
          inherit inputs;
          systemSettings = personalSettings;
          inherit userSettings;
        };
        modules = [
          inputs.catppuccin.homeModules.catppuccin
          ./profiles/personal/home.nix
        ];
      };

      homeConfigurations.wsl = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = wslPkgs;
        extraSpecialArgs = {
          inherit inputs;
          systemSettings = wslSettings;
          inherit userSettings;
        };
        modules = [
          inputs.catppuccin.homeModules.catppuccin
          ./profiles/wsl/home.nix
        ];
      };
    };
}
