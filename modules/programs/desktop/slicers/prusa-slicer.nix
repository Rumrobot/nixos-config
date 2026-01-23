{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.slicers.prusa-slicer";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.prusa-slicer];
}
