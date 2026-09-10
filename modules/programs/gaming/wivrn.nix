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

    programs.steam.package = pkgs.steam.override {
      extraProfile = ''
        # Allows Monado/WiVRn to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
        # Fixes timezones on VRChat
        # unset TZ
      '';
    };
  };
}
