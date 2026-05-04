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
    # Bypass openldap failing tests:
    # See: https://github.com/NixOS/nixpkgs/issues/513245#issuecomment-4320293674
    nixpkgs.overlays = [
      (_: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];
    environment.systemPackages = with pkgs; [
      javaPackages.compiler.temurin-bin.jre-17
      prismlauncher
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
