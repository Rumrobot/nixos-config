{
  config,
  lib,
  pkgs-unstable,
  username,
  ...
}: let
  cfg = config.nixosConfig.environment.terminals.ghostty;
  mkTerminalOption = import ./options.nix;
  package = pkgs-unstable.ghostty;
in {
  options.nixosConfig.environment.terminals.ghostty = mkTerminalOption {
    inherit lib package;
    cmd = "ghostty";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [package];
    };
  };
}
