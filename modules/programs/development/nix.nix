{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.development.nix";

  options = delib.singleEnableOption host.developmentFeatured;

  home.ifEnabled = {
    home.packages = with pkgs; [
      nixfmt
      deadnix
      statix
      nil
    ];
  };
}
