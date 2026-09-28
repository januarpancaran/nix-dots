{ inputs, ... }:
{
  programs.noctalia.settings = {
    plugins = {
      enabled = [ ];

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
