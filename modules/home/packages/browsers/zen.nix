{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.nixosConfig.browsers.zen;
in {
  imports = [inputs.zen-browser.homeModules.beta]; # beta / twilight

  options.nixosConfig.browsers.zen.enable =
    lib.mkEnableOption "Zen browser" // {default = true;};

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };
}
