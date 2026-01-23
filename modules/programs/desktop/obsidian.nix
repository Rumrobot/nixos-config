{
  delib,
  host,
  pkgs,
  ...
}: delib.module {
  name = "programs.desktop.obsidian";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.obsidian];
}
