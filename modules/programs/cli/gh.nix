{
  delib,
  host,
  pkgs,
  ...
}: delib.module {
  name = "programs.cli.gh";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.home.packages = [pkgs.gh];
}
