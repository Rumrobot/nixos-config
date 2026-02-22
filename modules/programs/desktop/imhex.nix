{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.imhex";

  options = delib.singleEnableOption host.hackingFeatured;

  home.ifEnabled.home.packages = with pkgs; [imhex xxd];
}
