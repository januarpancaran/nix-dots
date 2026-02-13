{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix4VsCode
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
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
        wm = "niri"; # or Hyprland
        defaultShell = "zsh"; # or bash
        githubUsername = "januarpancaran";
        githubEmail = "januar352@gmail.com";

        /**
          * Optional Features
          *
          * enableZenBrowser: Install Zen Browser. If false, defaulting browser to brave
          * enableProgrammingPkgs: Install all programming packages stated in profiles/home
          * enableClaudeModel: Enables claude model for Claude Code
          * enableGeminiModel: Enables gemini model for Claude Code
        */
        enableZenBrowser = false;
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

        overlays = [
          inputs.niri.overlays.niri
          inputs.nix4vscode.overlays.default
          (final: prev: {
            antigravity-claude-proxy = prev.buildNpmPackage {
              pname = "antigravity-claude-proxy";
              version = "2.7.3";

              src = prev.fetchFromGitHub {
                owner = "badrisnarayanan";
                repo = "antigravity-claude-proxy";
                rev = "v2.7.3";
                hash = "sha256-Mg7fJJC/5S4lywPbYJxy+Dn8T8O9jDYge1fsh989Hqw=";
              };

              npmDepsHash = "sha256-8WS6NLBMJFgyhC1jPqDX3XTOrc3li+8QybSwIxTtSEM=";
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
          inputs.zen-browser.homeModules.beta
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
        ];
      };
    };
}
