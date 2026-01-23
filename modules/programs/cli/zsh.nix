{
  delib,
  homeManagerUser,
  host,
  pkgs,
  lib,
  ...
}: delib.module {
  name = "programs.cli.zsh";

  options = with delib; {
    enable = boolOption host.cliFeatured;
    default = boolOption false;
  };

  nixos.ifEnabled = {cfg, ...}: {
    lib.optionalAttrs cfg.default {
      users.users.${homeManagerUser}.shell = pkgs.zsh;
    };
  };

  home.ifEnabled = {myconfig, ...}: {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = lib.optionalAttrs myconfig.programs.cli.zoxide.enable {
        cd = "z";
      };

      oh-my-zsh = {
        enable = true;
        plugins = lib.optionals myconfig.programs.cli.git.enable ["git"];
      };
    };
  };
}
