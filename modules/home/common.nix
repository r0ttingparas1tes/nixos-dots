{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/repos/nixos-dots/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    fastfetch = "fastfetch";
    foot = "foot";
    fuzzel = "fuzzel";
    hypr = "hypr";
    niri = "niri";
    shells = "shells";
    swaync = "swaync";
    tmux = "tmux";
    waybar = "waybar";
    yazi = "yazi";
    zsh = "zsh";
    "starship.toml" = "starship.toml";
    "hyfetch.json" = "hyfetch.json";
  };
  homeConfigs = {
    ".bash_profile" = ".bash_profile";
    ".bashrc" = ".bashrc";
    ".profile" = ".profile";
    ".zshenv" = ".zshenv";
  };
in
{
  imports = [ ./theme.nix ];

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    sl
  ];

  # Dotfiles
  # So, this thing sucks, but i dont want to maintain multiple versions of my same dotfiles just so they're "The nix way", I want to use these dotfiles on my arch machine too.
  # So my horrible way to fix it: dotfiles as submodule, i symlink it where the dots configs expect it to be, that way i dont deal with headaches of home manager or the individual configs.
  # You dont like it? sue me idk, is my own shit, we all suck at coding, cry me a river.

  home.file =
    {
      "repos/dotfiles".source = create_symlink "${dotfiles}";
    }
    // builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value.source = create_symlink "${dotfiles}/${homeConfigs.${name}}";
        })
        (builtins.attrNames homeConfigs)
    );

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/.config/${subpath}";
    recursive = true;
  }) configs;

  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "kde";
    QT_STYLE_OVERRIDE = "breeze";
  };
}
