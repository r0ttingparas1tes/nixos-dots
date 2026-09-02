{ ... }:
{
  imports = [ ../../../modules/home/common.nix ];

  home.username = "jazz";
  home.homeDirectory = "/home/jazz";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
