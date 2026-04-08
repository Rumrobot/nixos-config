{
  delib,
  host,
  lib,
  ...
}:
delib.module {
  name = "programs.desktop.ghostty";

  options = with delib; {
    programs.desktop.ghostty = {
      enable = boolOption host.guiFeatured;
      default = boolOption false;
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment.sessionVariables = lib.optionalAttrs cfg.default {
      TERMINAL = "ghostty";
    };
  };

  myconfig.ifEnabled = {
    helpers.binds.actions.terminal = delib.mkBindProvider "ghostty" ["ghostty"];
  };

  home.ifEnabled = {myconfig, ...}: {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = myconfig.programs.cli.zsh.enable;

      settings = {
        gtk-titlebar = false;
      };
    };
  };
}
