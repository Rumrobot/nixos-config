{delib, ...}:
delib.host {
  name = "LPC-NE";

  rice = "niri";
  type = "desktop";
  features = [
    "wireless"
    "hacking"
    "llm"
    "gaming"
  ];

  displays = [
    {
      name = "ASUSTek COMPUTER INC VG27A M9LMQS085761";
      primary = true;
      refreshRate = 165;
      width = 2560;
      height = 1440;
      x = 0;
      y = 0;
    }
    {
      name = "Samsung Electric Company S24R65x H4TN100177";
      refreshRate = 75;
      width = 1920;
      height = 1080;
      x = -1920;
      y = 180;
    }
  ];

  myconfig = {
    features = {
      podman.enable = true;
    };
    programs = {
      cli = {
        zsh = {
          enable = true;
          default = true;
        };
      };
      desktop = {
        wootility.enable = true;
      };
    };
  };

  nixos = {
    services.printing.enable = true;
    services.upower.enable = true;

    networking.networkmanager.enable = true;
  };
}
