# Configuration for desktop PC
# CPU: Intel(R) Core(TM) i7-3930K (12) @ 3.80 GHz
# GPU: NVIDIA GeForce GTX 1060 6GB
# RAM: 16 GB
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/desktop/niri.nix
      ../../modules/desktop/gaming.nix
      ../../modules/desktop/cleaning.nix
    ];
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

  users.users.jazz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "gamemode" "video" "render" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  services.displayManager.ly.enable = true;
  services.displayManager.ly.x11Support = false;
  programs.firefox.enable = true;
  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [

    #dev
    vscode
    vim
    neovim
    git
    gcc
    lua
    go
    tmux
    cmake
    gnumake
    devenv

    (chromium.override {
      commandLineArgs = [
        "--enable-features=AcceleratedVideoEncoder"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];
    })


    fastfetch
    hyfetch
    stow
    wget
    cmatrix
    cbonsai
    btop
    htop

    (yazi.override {
      _7zz = _7zz-rar;
    })
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

    qbittorrent
    piper
    libayatana-appindicator
    nvtopPackages.nvidia
  ];

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    font-awesome
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.noto
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];


  # NVIDIA
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  hardware.nvidia.modesetting.enable = true;

  services.openssh.enable = true;
  services.flatpak.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  

  system.stateVersion = "25.11";

}

