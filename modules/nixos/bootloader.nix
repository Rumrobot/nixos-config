{
  config,
  lib,
  ...
}: let
  hasNixos = config ? environment;
  cfg = config.nixosConfig.system.bootloader;
in {
  options.nixosConfig.system.bootloader = {
    enable = lib.mkEnableOption "Bootloader configuration" // {default = true;};
    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/vda";
      description = "Target device for GRUB";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf hasNixos {
      boot.loader.grub = {
        enable = true;
        device = cfg.device;
        useOSProber = true;
      };
    })
  ];
}
