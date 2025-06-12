{
  config,
  lib,
  pkgs,
  ...
}: let
  hasNixos = config ? environment;
  hasHome = config ? home;
  cfg = config.nixosConfig.packages.terminal;

  modules = lib.concatLists [
    (lib.optional hasNixos [
      {
        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    ])

    (lib.optional hasHome [
      {
        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    ])
  ];
in {
  options.nixosConfig.packages.terminal = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ghostty;
      description = "Terminal emulator package installed for the user";
    };
  };

  imports = modules;
}
