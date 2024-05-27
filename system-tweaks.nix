{ config, pkgs, ... }:

{
  documentation.nixos.enable = false;

  system.autoUpgrade.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d"; 

  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.kernelParams = [
  	"quiet"
  	"udev.log_level=3"
  	"mitigations=off"
  	"lpj=3110400" # individual
  	"nowatchdog"
  	"page_alloc.shuffle=1"
  	"threadirqs"
  	"split_lock_detect=off"
  	"intel_idle.max_cstate=1"
  	"pci=pcie_bus_perf"
    "libahci.ignore_sss=1"
  ];
  
  # silent boot
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  zramSwap.enable = true;
  zramSwap.algorithm = "lz4";
   
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = false;  

  security.rtkit.enable = true;
  
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  services.ananicy.enable = true;
  services.ananicy.package = pkgs.ananicy-cpp;
  services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;
  
  services.irqbalance.enable = true;
  services.dbus.implementation = "broker";

  # fix gamescope in steam
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };
  
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ]; # add Proton-GE in Steam
  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  programs.gamescope.enable = true;
  programs.gamescope.args = [
    "-f"
  	"-W 1920 -H 1080" # individual
  ];
}
