# Configuration for laptop being used as a shitty server lol
# CPU: Intel(R) Celeron(R) N3050 (2) @ 2.16 GHz
# GPU: Intel Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Integrated Graphics Controller @ 0.60 GHz [Integrated]
# RAM: 4GB

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/server
    ];
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # trusted-users = [ "root" "jazz" "@wheel" ];
      # builders = "ssh://jazz@fraKctured x86_64-linux /home/jazz/.ssh/nix-remote-builder 8";
      # max-jobs = 0;
    };
    # distributedBuilds = true;
    # buildMachines = [{
    #   hostName = "fraKctured";
    #   sshUser = "jazz";
    #   sshKey = "/home/jazz/.ssh/nix-remote-builder";
    #   system = "x86_64-linux";
    #   maxJobs = 8;
    #   supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
    # }];
  };
  nixpkgs.config.allowUnfree = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "starless";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 8000 8080 ];
  };
  time.timeZone = "America/Santiago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  services = {
    xserver.xkb.layout = "latam";
    openssh.enable = true;
  };
  users.users.jazz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  environment.systemPackages = with pkgs; [
    git
    tree
    wget
    vim
    neovim
    fastfetch
    stow
    wget
    eza
    btop
    starship

    yazi
    p7zip-rar
    chafa
    fd
    ffmpeg
    imagemagick
    jq
    poppler
    resvg
    ripgrep
    wl-clipboard
    zoxide
    unzip
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
  ];
  system.stateVersion = "25.05"; # Did you read the comment?
}

