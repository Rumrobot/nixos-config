{
  delib,
  host,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.gaming.wivrn";

  options = delib.singleEnableOption host.gamingFeatured;

  nixos.ifEnabled = {myconfig, ...}: {
    services.wivrn = {
      enable = true;
      openFirewall = true;

      autoStart = true;

      package = lib.mkIf myconfig.hardware.nvidia.enable (pkgs.wivrn.override {cudaSupport = true;});
    };
  };
}
