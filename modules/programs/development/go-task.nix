{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.development.go-task";

  options = delib.singleEnableOption host.developmentFeatured;

  home.ifEnabled.home.packages = [pkgs.go-task];
}
