{ config, pkgs, ... }:

{
  systemd.user.services.awww-daemon = {
    description = "Runs AWWW Daemon for wallpapers";

    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    # path= [ pkgs.awww ];

    serviceConfig = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      Restart = "on-failure";
      Environment = [
        "PATH=${pkgs.awww}/bin:/run/current-system/sw/bin"
      ];
    };
  };
}
