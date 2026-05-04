{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  myDesktop.niri.enable = true;
  myDesktop.apps.enable = true;
  myDesktop.cleaning.enable = true;
  myDesktop.gaming.enable = false;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    plymouth.enable = true;
  };

  networking = {
    hostName = "fraKctured";
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


  # Disable the X11 windowing system.
  services.xserver.enable = false;
  services.tuned.enable = true;
  services.power-profiles-daemon.enable = false;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.extraGSettingsOverrides = ''
  [org.gnome.mutter]
  experimental-features=['scale-monitor-framebuffer']
  '';

  services.xserver.xkb.layout = "latam";
  services.printing.enable = true;
  
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.jazz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Gaming
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    moonlight-qt
    piper
    libayatana-appindicator
  ];


  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  system.stateVersion = "25.05";

}

