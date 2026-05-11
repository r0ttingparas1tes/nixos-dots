# Configuration for desktop PC
# CPU: Intel(R) Core(TM) i7-3930K (12) @ 3.80 GHz
# GPU: NVIDIA GeForce GTX 1060 6GB
# RAM: 16 GB
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  myDesktop.niri.enable = true;
  myDesktop.apps.enable = true;
  myDesktop.cleaning.enable = true;
  myDesktop.gaming.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
  };

  networking = {
    hostName = "thraK";
    networkmanager.enable = true;
  };
  time.timeZone = "America/Santiago";

  i18n = {
    defaultLocale = "es_CL.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
    };
  };
  console = {
    useXkbConfig = true;
  };

  services.xserver.enable = false;
  services.tuned.enable = true;
  services.power-profiles-daemon.enable = false;

  # Configure keymap in X11
  services.xserver.xkb.layout = "latam";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.jazmin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "gamemode" "video" "render" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  services.displayManager.ly.enable = true;
  environment.systemPackages = with pkgs; [

  ];
  # NVIDIA
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  hardware.nvidia.modesetting.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  

  system.stateVersion = "25.11";

}

