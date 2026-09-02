{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.latex";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = with pkgs; [
    tectonic
    tex-fmt
    texlab
  ];
}
