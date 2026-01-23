{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.jetbrains.webstorm";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled.home.packages = [pkgs.jetbrains.webstorm];
}
