{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myDesktop.cleaning;
in
{
  options.myDesktop.cleaning = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable automatic system cleaning (GC + store optimisation)";
    };
  };

  config = mkIf cfg.enable {  
    nix.optimise.automatic =true; #helps the store stay optimized and saves on storage space
    nix.gc = { #garbage collection
      automatic = true;
      dates = "daily";
      options = "-d";
    };
  };
}
