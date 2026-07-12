{
  delib,
  inputs,
  pkgs,
  ...
}:
let
  elegoo-slicer = inputs.elegoo-slicer.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
delib.module {
  name = "programs.desktop.slicers.elegoo-slicer";

  options = delib.singleEnableOption false;

  home.ifEnabled = { myconfig, ... }: {
    home.packages = [
      (
        if myconfig.hardware.nvidia.enable then
          elegoo-slicer.override {
            withNvidiaGLWorkaround = true;
          }
        else
          elegoo-slicer
      )
    ];
  };
}
