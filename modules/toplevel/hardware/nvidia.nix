{
  delib,
  lib,
  config,
  ...
}:
delib.module {
  name = "hardware.nvidia";

  options.hardware.nvidia = with delib; {
    enable = boolOption false;
    open = boolOption false;
    legacy = boolOption false;
  };

  nixos.ifEnabled = {
    cfg,
    myconfig,
    ...
  }: {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      package =
        lib.mkIf cfg.legacy
        config.boot.kernelPackages.nvidiaPackages.legacy_580;

      open = cfg.open && !cfg.legacy;
      modesetting = lib.mkIf myconfig.gui.wayland.enable {
        enable = true;
      };
    };
  };
}
