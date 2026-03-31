{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "T14-NE";

  # TODO: Add power profile settings

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

    # TODO: Fix fingerprint scanner
    services.fprintd.enable = true;
  };
}
