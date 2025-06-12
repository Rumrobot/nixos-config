{
  config,
  lib,
  ...
}: let
  cfg = config.nixosConfig.system.keymap;
in {
  options.nixosConfig.system.keymap = {
    layout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Keyboard layout";
    };
    variant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keyboard variant";
    };
    console = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Console keymap";
    };
  };

  config = {
    console.keyMap = lib.mkDefault (cfg.console or (cfg.layout + "-latin1"));
    services.xserver.xkb.layout = cfg.layout;
    services.xserver.xkb.variant = cfg.variant;
  };
}
