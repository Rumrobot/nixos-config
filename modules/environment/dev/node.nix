{
  lib,
  config,
  pkgs-unstable,
  username,
  ...
}:
with lib; let
  cfg = config.nixosConfig.environment.dev.node;
in {
  options.nixosConfig.environment.dev.node = {
    enable = mkEnableOption "NodeJS";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs-unstable; [
        bun
      ];
    };
  };
}
