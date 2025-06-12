{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.nixosConfig.home.browsers.zen;
in {
  options.cfg.enable =
    lib.mkEnableOption "Zen browser" // {default = true;};

  options.cfg.version = lib.mkOption {
    type = lib.types.enum ["beta" "twilight"];
    default = "beta";
    description = "Zen browser version";
  };

  config = {
    imports = [inputs.zen-browser.homeModules.${cfg.version}];
    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };
}
