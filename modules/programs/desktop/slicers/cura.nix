{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.cura";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [pkgs.cura-appimage];
}
