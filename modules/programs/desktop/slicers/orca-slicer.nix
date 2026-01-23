{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.slicers.orca-slicer";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.orca-slicer];
}
