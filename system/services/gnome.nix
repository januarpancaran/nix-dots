{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;

  # Exclude GNOME bloatware
  environment.gnome.excludePackages = with pkgs; [
    epiphany       # GNOME Web (browser)
    geary          # email client
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-tour
    gnome-weather
    totem          # video player
    yelp           # help viewer
  ];
}
