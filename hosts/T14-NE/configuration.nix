{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "T14-NE";

  rice = "niri";
  type = "desktop";
  features = [
    "powersave"
    "wireless"
    "hacking"
    "llm"
  ];

  displays = [
    {
      name = "eDP-1"; # California Institute of Technology 0x1404
      primary = true;
      refreshRate = 60;
      width = 1920;
      height = 1200;
      x = 0;
      y = 0;
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
    };
  };

  nixos = {
    imports = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
    ];

    services.printing.enable = true;
    services.upower.enable = true;

    networking.useDHCP = false;
    networking.networkmanager.enable = true;

    # TODO: Add power profile settings
    services.tlp.pd.enable = true;
    services.tlp.settings = {
      RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau radeon xhci_hcd r8169";
    };

    # TODO: Fix fingerprint scanner
    services.fprintd.enable = true;
  };
}
