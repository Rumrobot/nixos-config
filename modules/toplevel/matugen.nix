{
  delib,
  inputs,
  host,
  ...
}:
delib.module {
  name = "matugen";

  # TODO: Fix matugen base16 color generation

  options.matugen = with delib; {
    enable = boolOption host.guiFeatured;
    type = strOption "scheme-tonal-spot";
    contrast = numberOption 0.0;
    lightness = numberOption 0.0;
    source_color_index = intOption 0;
  };

  home.always = {
    imports = [inputs.matugen.nixosModules.default];
  };

  home.ifEnabled = {
    myconfig,
    cfg,
    ...
  }: {
    programs.matugen = {
      inherit (cfg) type contrast source_color_index;
      enable = true;
      wallpaper = myconfig.rice.wallpaper;
      variant = myconfig.rice.polarity;
      lightness_dark = cfg.lightness;
      lightness_light = cfg.lightness;
      jsonFormat = "strip";
    };
  };
}
