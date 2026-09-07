{
  delib,
  host,
  pkgs,
  lib,
  config,
  ...
}:
delib.module {
  name = "programs.gaming.wivrn";

  options = delib.singleEnableOption host.gamingFeatured;

  nixos.ifEnabled = {
    services.wivrn = {
      enable = true;
      openFirewall = true;

      autoStart = true;

      package = lib.mkIf config.hardware.nvidia.enabled (pkgs.wivrn.override {cudaSupport = true;});
    };
  };
}
