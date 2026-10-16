{
  lib,
  pkgs,
  systemSettings,
  ...
}:
lib.mkIf systemSettings.enableContainers {
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-compose
  ];

  virtualisation = {
    containers = {
      enable = true;
      registries.settings = {
        registry = [
          {
            location = "docker.io";
          }
        ];
      };
    };

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
