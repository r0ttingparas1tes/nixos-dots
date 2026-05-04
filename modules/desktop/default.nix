{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./apps.nix
    ./cleaning.nix
    ./gaming.nix
    ./niri
  ]; 

  # Common Programs
  programs.starship.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    xdg-utils
    flatpak-xdg-utils
    shared-mime-info
    
    vim    
    neovim
    unzip
    
    fastfetch
    hyfetch
    
    stow
    wget
    
    cmatrix
    cbonsai
    btop
    htop
  ];
  
  # Fonts
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
  # Services
  services.flatpak.enable = true;
  # Common Misc
  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (
        subject.isInGroup("users") &&
        [
          "org.freedesktop.login1.reboot",
          "org.freedesktop.login1.reboot-multiple-sessions",
          "org.freedesktop.login1.power-off",
          "org.freedesktop.login1.power-off-multiple-sessions",
        ].indexOf(action.id) !== -1
      ) {
        return polkit.Result.YES;
      }
    });
  '';
}
