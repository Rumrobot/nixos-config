{ delib, host, ... }:
delib.module {
  name = "hardware.bluetooth";

  options = singleEnableOption host.wirelessFeatured;

  nixos.ifEnabled = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
