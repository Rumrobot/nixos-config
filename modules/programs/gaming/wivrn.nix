{
  delib,
  pkgs,
  lib,
  config,
  host,
  ...
}:
delib.module {
  name = "programs.gaming.wivrn";

  options = delib.singleEnableOption host.vrFeatured;

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
