{
  delib,
  lib,
  ...
}:
delib.module {
  name = "hardware.nvidia";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = true;

    hardware.nvidia.modesetting = lib.mkIf myconfig.gui.wayland.enable {
      enable = true;
    };
  };
}
