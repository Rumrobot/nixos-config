{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.development.rust";

  options = delib.singleEnableOption host.developmentFeatured;

  nixos.ifEnabled = {
    environment.systemPackages = [
      pkgs.cargo
    ];
  };
}
