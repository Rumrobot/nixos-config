{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.qidi-studio";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.qidi-studio];
}
