{ inputs, ... }:
{
  programs.noctalia.settings = {
    plugins = {
      # Enable the hypr-screen-mirror plugin
      enabled = [ "profidev/hypr-screen-mirror" ];

      # Add the community plugins as a source
      source = [
        {
          name = "community";
          kind = "path";
          location = "${inputs.noctalia-community-plugins}";
          enabled = true;
        }
      ];
    };
  };
}
