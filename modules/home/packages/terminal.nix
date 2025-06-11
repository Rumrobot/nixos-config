{ config, lib, pkgs, ... }:
let
  cfg = config.nixosConfig.packages.terminal;
in {
  options.nixosConfig.packages.terminal = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ghostty;
      description = "Terminal emulator package installed for the user";
    };
  };

  config = {
    home.packages = [ cfg.package ];
  };
}
