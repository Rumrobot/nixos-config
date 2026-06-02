{
  delib,
  host,
  pkgs,
  homeManagerUser,
  ...
}:
delib.module {
  name = "programs.development.python";

  options = delib.singleEnableOption host.developmentFeatured;

  home.ifEnabled.home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.build
    python3Packages.uv

    ruff
  ];
}
