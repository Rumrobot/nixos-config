{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.jetbrains.android-studio";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled.home.packages = [pkgs.android-studio];
}
