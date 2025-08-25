{ config, pkgs, ... }:

{
  systemd.services.vnc = {
    description = "wayvnc server";
    after = [ "network.target" "graphical-session.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "spag";
      ExecStart = ''
        ${pkgs.wayvnc}/bin/wayvnc
      '';
      Restart = "always";
      RestartSec = 10;
    };
  };
}
