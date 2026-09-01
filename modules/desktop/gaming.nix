{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myDesktop.gaming;
in
{
  options.myDesktop.gaming = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable gaming clients and utils";
    };
  };

  config = mkIf cfg.enable { 
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          temurin-jre-bin
          temurin-jre-bin-17
          temurin-jre-bin-8
        ];
      })
      steam-run
      vulkan-tools
      mangohud
      lutris
      (heroic.override {
        extraPkgs = pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
      })
    ];
  };
}
