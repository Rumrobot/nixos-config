{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.typst";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = with pkgs; [
    typst
    typstyle
    tinymist
  ];
}
