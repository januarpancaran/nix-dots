{ inputs, ... }:
{
  programs.noctalia.settings = {
    plugins = {
      enabled = [
        "elijaharch/wl-screen-mirror"
      ];

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
