{
  delib,
  host,
  homeManagerUser,
  pkgs,
  lib,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.cli.zsh";

  options = with delib; {
    programs.cli.zsh = {
      enable = boolOption host.cliFeatured;
      default = boolOption false;
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    programs.zsh.enable = true;

    users.users.${homeManagerUser}.shell =
      lib.mkIf cfg.default pkgs.zsh;
  };

  home.ifEnabled = {myconfig, ...}: {
    programs.zsh = {
      enable = true;
      dotDir = "${homeconfig.xdg.configHome}/zsh";

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
