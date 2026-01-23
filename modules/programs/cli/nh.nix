{
  delib,
  homeconfig,
  host,
  ...
}: delib.module {
  name = "programs.cli.nh";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled = {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "${homeconfig.home.homeDirectory}/nixos-config";
    };
  };
}
