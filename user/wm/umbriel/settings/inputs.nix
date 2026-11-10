{ ... }:
{
  programs.umbriel.settings = {
    input = {
      keyboard = {
        layout = "us";
        options = "ctrl:nocaps";
        numlock_toggle = false;
      };

      touchpad = {
        tap = true;
        natural_scroll = true;
      };

      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 32;
      };
    };
  };
}
