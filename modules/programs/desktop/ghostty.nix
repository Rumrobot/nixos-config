{ delib, host, pkgs, lib, ... }:
delib.module {
  name = "programs.desktop.ghostty";

  options = with delib; {
    enable = boolOption host.guiFeatured;
    default = boolOption false;
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment.sessionVariables = lib.optionalAttrs cfg.default {
      TERMINAL = "ghostty";
    };
  };

  home.ifEnabled = {
    home.packages = [pkgs.ghostty];
  };
}
