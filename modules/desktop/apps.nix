{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myDesktop.apps;
in
{
  options.myDesktop.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Desktop apps i use commonly";
    };
  };

  config = mkIf cfg.enable {  

    programs.firefox.enable = true;
    # System-wide packages
    environment.systemPackages = with pkgs; [
      (chromium.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoEncoder"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      })

      # MEDIA
      mpd
      cava
      mpc
      rmpc
      mpv
      vlc

      # Yazi and deps
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

      # Misc
      onlyoffice-desktopeditors
      discord
      qbittorrent
    ];

    # Example: environment variables
    #environment.variables = {
    #  EDITOR = "vim";
    #  BROWSER = "firefox";
    #};
  };
}
