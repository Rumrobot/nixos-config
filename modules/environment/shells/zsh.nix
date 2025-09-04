{
  config,
  username,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nixosConfig.environment.shells.zsh;
  mkShellOption = import ./options.nix;
  package = pkgs.zsh;
in {
  options.nixosConfig.environment.shells.zsh = mkShellOption {
    inherit lib package;
    name = "Zsh";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          cd = "z";
        };

        oh-my-zsh = {
          enable = true;
          plugins = ["git"];
        };
      };
    };
  };
}
