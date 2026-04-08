{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.networking.http";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = with pkgs; [yaak httptoolkit];
}
