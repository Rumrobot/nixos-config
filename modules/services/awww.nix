{
  delib,
  inputs,
  pkgs,
  ...
}: let
  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
in delib.module {
  name = "services.awww";

  options = {myconfig, ...}: {
    services.awww = delib.singleEnableOption myconfig.wayland.enable;
  };

  home.ifEnabled = {
    home.packages = [awww];

    systemd.user.services.awww = {
      Install = {WantedBy = ["graphical-session.target"];};

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "awww";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${awww}/bin/awww-daemon";
        ExecStop = "${awww}/bin/awww kill";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
