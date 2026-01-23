{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.desktop.networking.yaak";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.yaak];
}
