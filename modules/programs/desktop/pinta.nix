{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.desktop.pinta";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.pinta];
}
