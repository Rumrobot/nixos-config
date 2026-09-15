{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "T14-NE";

  rice = "niri";
  type = "laptop";
  features = [
    "powersave"
    "development"
    "hacking"
    "llm"
  ];

  displays = [
    {
      name = "Lenovo Group Limited 0x403A Unknown"; # California Institute of Technology 0x1404
      portName = "eDP-1";
      primary = true;
      refreshRate = 60;
      width = 1920;
      height = 1200;
      x = 0;
      y = 0;
    }
    {
      name = "NEC Corporation E222W 9Z307555NB";
      portName = "temp"; # TODO: figure out real port name
      refreshRate = 60;
      width = 1680;
      height = 1050;
      x = -72;
      y = -1050;
    }
    {
      name = "PNP(AOC) 2460G4 GJXH9HA034303";
      portName = "temp2"; # TODO: figure out real port name
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = -192;
      y = -1080;
    }
  ];

  myconfig = {
    hardware.fingerprint.enable = false; # TODO: fix fingerprint module on T14-NE

    services = {
      greetd.enable = false;
      noctalia-greeter.enable = true;
      kdeconnect.enable = true;
    };

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

      # DTU
      dtu.enable = true;
      development.java.enable = true;

      desktop.slicers = {
        anycubic-slicernext.enable = true;
        bambu-studio.enable = true;
        crealityprint.enable = true;
        cura.enable = true;
        prusa-slicer.enable = true;
        qidi-studio.enable = true;
        elegoo-slicer.enable = true;
        flash-studio.enable = true;
      };
    };
  };

  nixos = {
    hardware.enableRedistributableFirmware = true;

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
  };
}
