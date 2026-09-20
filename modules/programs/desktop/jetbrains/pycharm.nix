{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.jetbrains.pycharm";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      enable = boolOption (host.guiFeatured && host.developmentFeatured && myconfig.programs.development.python.enable);
    });

  home.ifEnabled.home.packages = [pkgs.jetbrains.pycharm];
}
