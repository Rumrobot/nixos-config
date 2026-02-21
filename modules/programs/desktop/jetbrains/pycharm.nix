{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.jetbrains.pycharm";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled.home.packages = [pkgs.jetbrains.pycharm-oss];
}
