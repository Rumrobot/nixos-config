{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.nixosConfig.browsers.zen;
in {
  imports = [inputs.zen-browser.homeModules.${cfg.version}];

  options.nixosConfig.browsers.zen = {
    enable = lib.mkEnableOption "Zen browser" // {default = true;};
    version = lib.mkOption {
      type = lib.types.enum ["beta" "twilight"];
      default = "beta";
      description = "Zen browser version";
    };
  };

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
