{ pkgs, ...}:
{
  imports = [
    ../../home/
  ];
  home.stateVersion = "25.05";
  home.sessionVariables = {
    EDITOR = "nvim"
  };
}
