{ config, pkgs, ... }:

{
  systemd.user.services.cliphist = {
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/sh -c '\\
        ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store & \\
        ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store \\
      '";
      Restart = "on-failure";
    };

    wantedBy = [ "graphical-session.target" ];
  };
}
