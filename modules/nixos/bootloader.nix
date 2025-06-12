{
  config,
  lib,
  ...
}: let
  cfg = config.nixosConfig.system.bootloader;
in {
  options.nixosConfig.system.bootloader = {
    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/vda";
      description = "Target device for GRUB";
    };
  };

  config = {
    boot.loader.grub = {
      enable = true;
      device = cfg.device;
      useOSProber = true;
    };
  };
}
