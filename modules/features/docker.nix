{ delib, host, ...}:
delib.module {
  name = "features.docker";

  options = delib.singleEnableOption host.developmentFeatured;

  nixos.ifEnabled.virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
