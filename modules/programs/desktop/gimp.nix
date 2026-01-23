{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.desktop.gimp";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.gimp3];
}
