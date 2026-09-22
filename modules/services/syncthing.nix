{
  delib,
  host,
  ...
}:
delib.module {
  name = "services.syncthing";

  options = delib.singleEnableOption host.guiFeatured;

  # TODO: configure devices with opnix secrets
  home.ifEnabled = {
    services.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
