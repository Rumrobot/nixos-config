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
      default = "dk";
      description = "Keymap layout";
    };
    variant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keymap variant";
    };
    options = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keymap options";
    };
    console = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.layout}-latin1";
      description = "Console keymap";
    };
  };

  config = {
    console.keyMap = cfg.console;
    services.xserver.xkb.layout = cfg.layout;
    services.xserver.xkb.variant = cfg.variant;
  };
}
