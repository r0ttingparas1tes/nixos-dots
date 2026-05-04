{ config, pkgs, ... }:

{
  systemd.user.services.awww-daemon = {
    description = "Runs AWWW Daemon for wallpapers";

    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      Restart = "on-failure";
    };
  };
}
