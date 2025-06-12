{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.nixosConfig.browsers.zen;
in {
  options.nixosConfig.browsers.zen = {
    enable = lib.mkEnableOption "Zen browser" // {default = true;};
    version = lib.mkOption {
      type = lib.types.enum ["beta" "twilight"];
      default = "beta";
      description = "Zen browser version";
    };
  };

  config = with inputs;
    lib.mkIf cfg.enable {
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
