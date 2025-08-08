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

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Zsh plugins
    zsh-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
  };

  outputs = { self, ... } @ inputs: 
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "hayudaang";
      profile = "personal";
      bootloader = "grub";
      bootloaderDevice = [ "nodev" ];
      bootloaderEfiMountPoint = "/boot/efi";
      timeZone = "Asia/Jakarta";
      flakeDir = ("/home/" + userSettings.username + "/.dotfiles");
    };

    userSettings = {
      username = "daangsangu";
      githubUsername = "januarpancaran";
      githubEmail = "januar352@gmail.com";
    };

    pkgs = import inputs.nixpkgs {
      system = systemSettings.system;
      config = {
	allowUnfree = inputs.nixpkgs.lib.mkDefault true;
	allowBroken = inputs.nixpkgs.lib.mkDefault false;
      };
      overlays = [ inputs.niri.overlays.niri ];
    };
  in
  {
    nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
      system = systemSettings.system;

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
	(./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
      ];
    };
  };
}
