{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.desktop.vicinae";

  # TODO: Add binds after the binds options have been completed

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    services.vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
        environment = {
          USE_LAYER_SHELL = 1;
        };
      };
    };
  };
}
