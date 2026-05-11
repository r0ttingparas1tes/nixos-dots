{ config, pkgs, ... }:

{
systemd.user.services.awww-daemon = {
  description = "AWWW wallpaper daemon";

  wantedBy = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];

  path = [
    pkgs.awww
    pkgs.coreutils
  ];

  serviceConfig = {
    ExecStart = "${pkgs.awww}/bin/awww-daemon";
    Restart = "on-failure";
  };
};
}
