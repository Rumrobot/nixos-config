{delib, ...}:
delib.module {
  name = "services.kdeconnect";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.kdeconnect.enable = true;
  };

  nixos.ifEnabled = {
    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
