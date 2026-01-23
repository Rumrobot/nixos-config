{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.beeper";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.beeper];
}
