{ config, pkgs, ... }:

{
  imports = [
    # ./system-age.nix
    ./cliphist.nix
    ./gnome-polkit.nix
    ./nm-applet.nix
    ./awww-daemon.nix
  ];
}
