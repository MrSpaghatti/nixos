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
        ${pkgs.wayvnc}/bin/wayvnc 0.0.0.0
      '';
      Restart = "always";
      RestartSec = 10;
      StandardOutput = "file:/tmp/wayvnc.log";
      StandardError = "file:/tmp/wayvnc.log";
    };
  };
}
