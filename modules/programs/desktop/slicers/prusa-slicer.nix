{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.prusa-slicer";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [pkgs.prusa-slicer];
}
