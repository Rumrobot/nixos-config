{
  nixosConfig,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = nixosConfig.home.browsers.zen.enable;
in {
  options.nixosConfig.home.browsers.zen.enable =
    lib.mkEnableOption "Zen browser" // {default = true;};

  config = lib.mkIf cfg {
    imports = [inputs.zen-browser.homeModules.beta];

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };
}
