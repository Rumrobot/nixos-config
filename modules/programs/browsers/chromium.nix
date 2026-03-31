{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.browsers.chromium";

  options = delib.singleEnableOption host.guiFeatured;

  # TODO: Enable programs.chromium in NixOS to support stylix
  home.ifEnabled.home.packages = [pkgs.ungoogled-chromium];
}
