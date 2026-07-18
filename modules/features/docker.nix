{
  delib,
  host,
  ...
}:
delib.module {
  name = "features.docker";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      enable = boolOption (host.developmentFeatured && !myconfig.features.podman.enable);
    });

  nixos.ifEnabled.virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
