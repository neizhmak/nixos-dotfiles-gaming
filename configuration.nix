{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./gnome-tweaks.nix
      ./system-tweaks.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.hostId = "19752c9c";
  networking.networkmanager.enable = true;
  
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  
  users.users.user.isNormalUser = true;
  users.users.user.description = "User";
  users.users.user.extraGroups = [ "networkmanager" "wheel" ];
  users.users.user.packages = with pkgs; [
    chromium
    micro
    easyeffects
    lutris
    fastfetch
    #mumble
  ];
  
  nixpkgs.config.allowUnfree = true;
  
  hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
  ];

#   services.xserver.videoDrivers = ["nvidia"];
# 
#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = false;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
#   };
#
#   nixpkgs.config.nvidia.acceptLicense = true;  

  system.stateVersion = "23.11";
}
