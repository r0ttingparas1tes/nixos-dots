{ config, pkgs, ... }:

{
  systemd.user.services.nm-applet = {
    description = "NetworkManager Applet";

    after = [ "waybar.service" "graphical-session.target" ];
    wants = [ "waybar.service" "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      Restart = "on-failure";
    };

    wantedBy = [ "graphical-session.target" ];
  };
}
