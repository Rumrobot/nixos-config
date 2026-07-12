{ delib, ... }:
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
      refreshRate = 164.999;
      width = 2560;
      height = 1440;
      x = 0;
      y = 0;
    }
    {
      name = "Samsung Electric Company S24R65x H4TN100177";
      refreshRate = 74.973;
      width = 1920;
      height = 1080;
      x = -1920;
      y = 180;
    }
  ];

  myconfig = {
    boot.loader = "systemd-boot";
    hardware.nvidia = {
      enable = true;
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
      desktop = {
        wootility.enable = true;
        coolercontrol.enable = true;
      };
      development.godot.enable = true;
    };
  };

  nixos = {
    # Windows support for bootloader
    boot.loader.systemd-boot = {
      windows = {
        "windows" =
          let
            boot-drive = "FS2";
          in
          {
            title = "Windows";
            efiDeviceHandle = boot-drive;
            sortKey = "y_windows";
          };
      };

      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };

    services.printing.enable = true;
    services.upower.enable = true;

    networking.networkmanager.enable = true;
  };
}
