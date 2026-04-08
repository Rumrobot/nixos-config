{
  delib,
  host,
  ...
}:
delib.module {
  name = "features.docker";

  options = {myconfig, ...}:
    with delib; {
      features.docker = boolOption (host.developmentFeatured && !myconfig.features.podman.enable);
    };

  nixos.ifEnabled.virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
