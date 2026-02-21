{delib, host, pkgs, homeManagerUser, ...}:
delib.module {
  name = "programs.development.nodejs";

  options = delib.singleEnableOption host.developmentFeatured;

  home.ifEnabled.home.packages = with pkgs; [ nodejs_24 bun];
}
