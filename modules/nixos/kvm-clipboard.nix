{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nixosConfig.system.kvm-clipboard;
in {
  options.nixosConfig.system.kvm-clipboard.enable =
    lib.mkEnableOption "Clipboard integration for KVM";

  config = lib.mkIf cfg.enable {
    services.spice-vdagentd.enable = true;

    systemd.user.services.spice-vdagent-client = {
      description = "spice-vdagent client";
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
    systemd.user.services.spice-vdagent-client.enable = true;
  };
}
