{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Languages
    nodejs
    lua

    # Build Tools
    gcc
    cmake

    # Dev tools
    tmux
    devenv
    # statix
    # deadnix
    # nixfmt

    # Editor
    vscode
    # Programs
    # cisco-packet-tracer_9
  ];
  programs.direnv.enable = true;
}
