{
  delib,
  inputs,
  pkgs,
  ...
}: let
  flash-studio = inputs.flash-studio.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
  delib.module {
    name = "programs.desktop.slicers.flash-studio";

    options = delib.singleEnableOption false;

    myconfig.ifEnabled.hardware.networking.ssdp = true;

    home.ifEnabled = {myconfig, ...}: {
      home.packages = [
        (
          if myconfig.hardware.nvidia.enable
          then
            flash-studio.override {
              withNvidiaGLWorkaround = true;
            }
          else flash-studio
        )
      ];
    };

    nixos.ifEnabled.networking.firewall = {
      allowedUDPPorts = [
        19000 # FlashForge printer discovery
      ];
    };
  }
