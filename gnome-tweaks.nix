{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-connections
    gnome-photos
    gnome-tour
    snapshot
  ]) ++ (with pkgs.gnome; [
    atomix
    baobab
    cheese
    epiphany
    evince
    geary
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-remote-desktop
    gnome-weather
    hitori
    iagno
    seahorse
    simple-scan
    tali
    totem
    yelp
  ]);

  environment.systemPackages = with pkgs; [
  	pkgs.gnomeExtensions.dash-to-dock
  	pkgs.gnomeExtensions.appindicator
  	pkgs.gnomeExtensions.quick-lang-switch
  ];
}
