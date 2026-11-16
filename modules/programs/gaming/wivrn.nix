{
  delib,
  pkgs,
  lib,
  config,
  ...
}:
delib.module {
  name = "programs.gaming.wivrn";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.wivrn = {
      enable = true;
      package = lib.mkIf config.hardware.nvidia.enabled (pkgs.wivrn.override {cudaSupport = true;});
      openFirewall = true;
      steam.importOXRRuntimes = true;

      autoStart = true;
    };
  };
}
