{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.desktop.vicinae";

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

      # window = {
      #   csd = true;
      #   opacity = 0.95;
      #   rounding = 10;
      # };
    };
  };
}
