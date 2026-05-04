{ config, pkgs, ... }:

{
  imports = [
    # ./system-age.nix
    ./cliphist.nix
    ./nm-applet.nix
    ./awww-daemon.nix
  ];
}
