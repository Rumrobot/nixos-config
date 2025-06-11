{ config, lib, pkgs, ... }:
let
  cfg = config.nixosConfig.system.kvmClipboard.enable;
in {
  options.nixosConfig.system.kvmClipboard.enable =
    lib.mkEnableOption "Clipboard integration for KVM";

  config = lib.mkIf cfg {
    services.spice-vdagentd.enable = true;

    systemd.user.services.spice-vdagent-client = {
      description = "spice-vdagent client";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
    systemd.user.services.spice-vdagent-client.enable = true;
  };
}
