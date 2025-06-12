{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  hasNixos = config ? environment;
  hasHome = config ? home;
in {
  options.nixosConfig.home.browsers.zen.enable =
    lib.mkEnableOption "Zen browser" // {default = true;};

  config = lib.mkMerge [
    (lib.mkIf hasHome {
      imports = [inputs.zen-browser.homeModules.beta];
      programs.zen-browser = {
        enable = true;
        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
        };
      };
    })
  ];
}
