{
  config,
  lib,
  pkgs,
  ...
}: let
  hasNixos = config ? environment;
  hasHome = config ? home;
  cfg = config.nixosConfig.packages.terminal;
in {
  options.nixosConfig.packages.terminal = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ghostty;
      description = "Terminal emulator package installed for the user";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf hasHome {
      home.packages = [cfg.package];
    })
    (lib.mkIf hasNixos {
      environment.systemPackages = [cfg.package];
    })
  ];
}
