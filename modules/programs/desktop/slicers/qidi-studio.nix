{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.qidi-studio";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [pkgs.qidi-studio];
}
