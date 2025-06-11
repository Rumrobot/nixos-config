{ config, lib, ... }:
let
  cfg = config.nixosConfig.system.bootloader;
in {
  options.nixosConfig.system.bootloader = {
    enable = lib.mkEnableOption "Bootloader configuration" // { default = true; };
    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/vda";
      description = "Target device for GRUB";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      device = cfg.device;
      useOSProber = true;
    };
  };
}
