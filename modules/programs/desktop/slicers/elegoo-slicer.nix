{
  delib,
  inputs,
  pkgs,
  config,
  ...
}: let
  elegoo-slicer = inputs.elegoo-slicer.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
  delib.module {
    name = "programs.desktop.slicers.elegoo-slicer";

    options = delib.singleEnableOption false;

    home.ifEnabled = {
      home.packages = [
        (
          if config.hardware.nvidia.enabled
          then
            elegoo-slicer.override {
              withNvidiaGLWorkaround = true;
            }
          else elegoo-slicer
        )
      ];
    };
  }
