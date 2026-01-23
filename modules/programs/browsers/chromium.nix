{
  delib,
  host,
  pkgs,
  ...
}: delib.module {
  name = "programs.browsers.chromium";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.ungoogled-chromium];
}
