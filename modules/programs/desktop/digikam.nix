{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.digikam";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [pkgs.digikam];
}
