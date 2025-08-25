{ config, pkgs, ... }:

{
  systemd.services.vnc = {
    description = "TigerVNC server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "spag";
      ExecStart = ''
        ${pkgs.tigervnc}/bin/x0vncserver -passwordfile /home/spag/.vnc/passwd -display :0
      '';
      Restart = "always";
      RestartSec = 10;
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/spag/.vnc 0700 spag users -"
    "f /home/spag/.vnc/passwd 0600 spag users - ${pkgs.tigervnc}/bin/vncpasswd -f <<< nixos"
  ];
}
