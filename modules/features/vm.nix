{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "features.vm";

  options = delib.singleEnableOption host.vmFeatured;

  nixos.ifEnabled = {
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
    systemd.user.services.spice-vdagent-client.enable = true; # TODO: Service configured in home-manager?
  };
}
